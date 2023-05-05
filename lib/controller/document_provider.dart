import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:note/core/widget/dialog/delete_dialog.dart';
import 'package:note/model/document.dart';

import '../core/widget/dialog/image_dialog.dart';

class DocumentProvider with ChangeNotifier {
  Box documentBox = Hive.box(AppConstant.fileBox);

  Future<void> putDocument(
      String filePath, String fileName, String folderPath) async {
    int key = await documentBox.add(AppConstant.myDocument);
    Document document = Document(
        id: key,
        filePath: filePath,
        folderName: folderPath,
        fileName: fileName);
    await documentBox.put(key, document);
    notifyListeners();
  }

  Future<void> clearBox() async {
    int len = await documentBox.clear();
    notifyListeners();
    print(len);
  }

  List<dynamic> getDocumentsByFolderKey(String folderKey) {
    List<dynamic> docs = [];
    documentBox.values.toList().forEach((element) {
      if (folderKey == element.folderName) {
        docs.add(element);
      }
    });
    return docs;
  }

  Future<void> deleteDocumentByKey(int key) async {
    documentBox.delete(key);
    notifyListeners();
  }

  Future<List<String?>?> getFilePath(FolderType folderType) async {
    FileType fileType = convertFolderTypeToFileType(folderType);
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
          dialogTitle: "choseFile", type: fileType, allowedExtensions: ["jpg"]);
      if (result != null) {
        PlatformFile file = result.files.first;

        return [file.path, file.name];
      } else {
        return null;
      }
    } catch (e) {
      print("error in load your file " + e.toString());
      return null;
    }
  }

  onTabDocument(
      BuildContext context, Document document, FolderType folderType) {
    switch (folderType) {
      case FolderType.txt:
        return;
      case FolderType.video:
        // do later
        return;
      case FolderType.audio:
        // do later
        return;
      case FolderType.image:
        _onTabDocumentImage(context, document);
        return;
      case FolderType.exel:
        // do later
        return;
    }
  }

  _onTabDocumentImage(BuildContext context, Document document) {
    showDialog(
        context: context,
        builder: (context) {
          return ImageDialog(imagePath: document.filePath);
        });
  }

  _onTabDocumentText(BuildContext context, Document document) {
    // do later
  }

  _onTabDocumentVideo(BuildContext context, Document document) {
    // do later
  }

  _onTabDocumentAudio(BuildContext context, Document document) {
    // do later
  }

  _onTabDocumentExel(BuildContext context, Document document) {
    // do later
  }

  onDoubleTabDocument(
      BuildContext context, Document document, FolderType folderType) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialog(
            contentMessage:
                "Are you sure you want to delete ${document.fileName}",
            documentId: document.id,
            title: 'Delete Document',
          );
        });
  }
}
