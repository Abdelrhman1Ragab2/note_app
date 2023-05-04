import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:note/model/folders.dart';

class FolderProvider with ChangeNotifier {

  TextEditingController dialogController =TextEditingController();
  FolderType folderType = FolderType.txt;

  Box folderBox = Hive.box(AppConstant.folderBox);

  changeFolderType(FolderType type){
    folderType=type;
    notifyListeners();
  }

  Future<void> crateFolder(String name, String type) async {
    int key = await folderBox.add(null);
    Folder folder = Folder(id: key, name: name, type: type);
    await folderBox.put(key, folder);
    notifyListeners();
  }

  Future<void> clearBox() async {
    int len = await folderBox.clear();
    notifyListeners();
    print(len);
  }

  List<dynamic> getFolders() {
    return folderBox.values.toList();
  }

  Future<void> updateFolder(Folder folder) async {
    await folderBox.put(folder.id, folder);
  }
}
