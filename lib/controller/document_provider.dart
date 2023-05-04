import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/model/document.dart';

class DocumentProvider with ChangeNotifier{


  Box documentBox= Hive.box(AppConstant.fileBox);



  Future<void> putDocument(String filePath,String folderPath)
  async{

    int key=await documentBox.add(AppConstant.myDocument);
    Document document=Document(id: key,filePath: filePath, folderNamePath: folderPath);
    await documentBox.put(key, document);
    notifyListeners();
  }

  Future<void> clearBox() async {
    int len=await documentBox.clear();
    notifyListeners();
    print(len);
  }

  List<dynamic> getDocumentsByFolderKey(String folderKey) {
    List<dynamic> docs=[];
      documentBox.values.toList().forEach((element) {
       if(folderKey==element.folderNamePath){
         docs.add(element);
       }

     });
     return docs;
  }

  Future<void> deleteDocumentByKey(int key) async {
    documentBox.delete(key);
    notifyListeners();
  }

  Future<String?> getFilePath()async{
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: "choseFile",
        type: FileType.video,
        allowedExtensions: ["jpg"]

      );
      if (result != null) {
        PlatformFile file = result.files.first;

        return file.path;

      }
      else {
        return null;
      }

    } catch (e) {
      print("error in load your file "+e.toString());
      return null;
    }

  }




}