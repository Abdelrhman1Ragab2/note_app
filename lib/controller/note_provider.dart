
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:note/core/app_constant.dart';
import 'package:note/model/note.dart';

class NoteProvider with ChangeNotifier {

  var noteBox=Hive.box(AppConstant.noteBox);
  int  len=Hive.box(AppConstant.noteBox).length;
  Future<void>clearBox()async{
   await noteBox.clear();
  }


  Future<void> putNoteItem({String title = "", required String content,
    String imageURl = "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"
  }) async {
   await noteBox.add(Note(id: "id", title: title, creationDate: DateTime.now().toString(),
        lastUpdate: DateTime.now().toString(), content: content, coverImageUrl: imageURl)
    );
   notifyListeners();
   print("add sucsess");
  }


  List<dynamic> getNotes()  {
    return noteBox.values.toList();
  }


}