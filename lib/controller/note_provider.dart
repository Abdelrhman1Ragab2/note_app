import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/model/note.dart';

class NoteProvider with ChangeNotifier {

  Box noteBox = Hive.box(AppConstant.noteBox);
  String newImageUrl = "";
  bool isDefaultImage = true;

  void changeDefaultImage(String imageUrl) {
    newImageUrl = imageUrl;
    isDefaultImage = false;
    notifyListeners();
  }

  void resetDefaultBoolean() {
    isDefaultImage = true;
    notifyListeners();
  }

  Future<void> clearBox() async {

    int len=await noteBox.clear();
    print(len);

  }


  Future<void> putNoteItem({String title = "", required String content,
  }) async {
    int key = await noteBox.add(AppConstant.myNote);
    Note note = Note(
        id: key.toString(),
        title: title,
        isDefaultImage: isDefaultImage,
        lastUpdate: DateTime.now().toString(),
        content: content,
        coverImageUrl: isDefaultImage ?
        AppConstant.defaultImageURl
            : newImageUrl);
    await noteBox.put(key, note);
    await noteBox.flush();

    notifyListeners();
  }


  List<dynamic> getNotes() {
    return noteBox.values.toList();
  }

  Future<void> deleteNoteByKey(String key) async {
    noteBox.delete(int.parse(key));
    notifyListeners();
  }

  Future<void> updateNoteByKey(
      {required String key, required String newTitle, required String newContent, required newImage, required bool isDefaultImg}) async {
    final note = Note(
        id: key,
        title: newTitle,
        isDefaultImage: isDefaultImg,
        lastUpdate: DateTime.now().toString(),
        content: newContent,
        coverImageUrl: newImage);

    await noteBox.put(int.parse(key),note);
    notifyListeners();
  }


}