import 'package:note/model/document.dart';
import 'package:note/model/folders.dart';
import 'package:note/model/note.dart';

class AppConstant {
  /// boxs
  static const noteBox = "myNoteBox4";
  static const fileBox = "myFileBox";
  static const folderBox = "myFolderBox";
  static const dSummaryBox = "mydSummaryBoxBox1";
  static const taskBox = "myTaskBox";

  static const String defaultImageURl =
      "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80";

  /// default box
  static Note myNote = Note(
      id: "fake",
      title: "title",
      isDefaultImage: true,
      lastUpdate: "lastUpdate",
      content: "content",
      coverImageUrl: "coverImageUrl");
  static Document myDocument =
      Document(id: 999, filePath: "path", folderName: "path", fileName: "fake");
  static Folder myFolder = Folder(id: 999, name: "path", type: "path");

  /// monthLabel for daySummary
  static const Map<String,int> monthLabel = {
    "January":31,
    "February":28,
    "March":31,
    "April":30,
    "May":31,
    "June":30,
    "July":31,
    "August":31,
    "September":30,
    "October":31,
    "November":30,
    "December":31,
  };
}
