

enum FolderType {image,txt,exel,audio,video}


String convertFolderTypeToString(FolderType folderType){

  switch(folderType){
    case FolderType.txt:
      return "txt";
    case FolderType.video:
      return "video";
    case FolderType.audio:
      return "audio";
    case FolderType.image:
      return "image";
    case FolderType.exel:
      return "exel";

  }

}


FolderType convertStringToFolderType(String string){

  switch(string){
    case "txt":
      return FolderType.txt;
    case "video":
      return FolderType.video;
    case "audio":
      return FolderType.audio;
    case "image":
      return FolderType.image;
    case "exel":
      return FolderType.exel;

  }
  return FolderType.txt;


}