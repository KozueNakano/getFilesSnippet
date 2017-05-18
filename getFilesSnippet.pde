import java.util.List;
import java.util.Arrays;

final int[] selectButtonPlace = {300,50,80,50};
final int[] DirNamePlace = {20,50,250,50};
String DirNameMessage = "Select wavData Folder";
final int[] fileListArea = {20,120,250,150};
String fileListMassage = "";
String[] extension = {".txt"};//この拡張子のファイルだけ読み込む
List<File> sortedFiles = new ArrayList<File>();

void setup() {
  size(400,500);
}

void draw(){
  //selectButton
  fill(10,10,60);
  rect(selectButtonPlace[0],selectButtonPlace[1],selectButtonPlace[2],selectButtonPlace[3]);
  fill(255);
  textSize(16);
  text("DROP IN",selectButtonPlace[0]+5,selectButtonPlace[1]+30);
  //selected Dir name
  fill(10,10,60);
  rect(DirNamePlace[0],DirNamePlace[1],DirNamePlace[2],DirNamePlace[3]);
  fill(255);
  textSize(12);
  text(DirNameMessage,DirNamePlace[0]+10,DirNamePlace[1]+5,230,100);
  //fileListArea
  fill(10,10,60);
  rect(fileListArea[0],fileListArea[1],fileListArea[2],fileListArea[3]);
  fill(255);
  textSize(12);
  text(fileListMassage,fileListArea[0]+10,fileListArea[1]+5,fileListArea[2]-20,fileListArea[3]-10);
  
}

void mouseClicked(){
  if(    selectButtonPlace[0]<mouseX 
      && selectButtonPlace[0]+selectButtonPlace[2]>mouseX
      && selectButtonPlace[1]<mouseY
      && selectButtonPlace[1]+selectButtonPlace[3]>mouseY){
        selectFolder("Select a wavData folder", "folderSelected");
  }
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    DirNameMessage = selection.getAbsolutePath();
    
    sortedFiles(selection , sortedFiles);
    
    //show
        for(int i =0;i<sortedFiles.size();i++){
    fileListMassage += sortedFiles.get(i).getPath()+"\n";
  }
    
  }
}




void sortedFiles (File selection , List<File> sortedFiles){
  //filelist　指定した拡張子かつ頭三桁が数字で始まるファイルのパスを取得
    List<File> files = Arrays.asList(selection.listFiles());
    sortedFiles.clear();
    int sortIndex = 0;
    for(int i=0; i < files.size();i++){
      for(String extension : extension){//拡張子の種類ごとに繰り返される
        if(files.get(i).getPath().endsWith(extension)){//拡張子一致したら
        String No = files.get(i).getName().substring(0,3);
        if(int(No)>0&&int(No)<=files.size()){//ファイルネーム1~個数まで
              sortedFiles.add(sortIndex,files.get(i));
              sortIndex++;
        }
        }
      }
    }

    //sort　取得したパスリストを頭三桁の数値でソート
    sortIndex--;
    for(int i=0;i<sortIndex;i++){
      for(int j=sortIndex;j>i;j--){
        if(int(sortedFiles.get(j).getName().substring(0,3)) < int(sortedFiles.get(j-1).getName().substring(0,3))){
          File temp = sortedFiles.get(j);
          sortedFiles.set(j,sortedFiles.get(j-1));
          sortedFiles.set(j-1,temp);
        }
      }
    }
}