import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:note/model/document.dart';
import 'package:provider/provider.dart';

import '../../../core/widget/dialog/image_dialog.dart';
import '../../../core/widget/my_text.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({Key? key}) : super(key: key);
  static const routeName = "DocumentationScreen";

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String folderName = routeArg["folderName"];
    final FolderType folderType = routeArg["folderType"];
    return Scaffold(
      appBar: AppBar(
        title: myText(folderName),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () async {
            List<String?>? fileData =
                await Provider.of<DocumentProvider>(context, listen: false)
                    .getFilePath(folderType);

            if ( fileData != null) {
              await Provider.of<DocumentProvider>(context, listen: false)
                  .putDocument(fileData[0]!,fileData[1]!, folderName);
            } else {
            }
          },
          child: const Icon(Icons.upload)),
      body: Platform.isWindows
          ? buildBodyWindows(context, folderName, folderType)
          : buildBodyForMobile(context, folderName, folderType),
    );
  }

  Widget buildBodyWindows(
      BuildContext ctx, String folderName, FolderType folderType) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 150,
      ),
      itemBuilder: (context, index) {
        return documentBody(
            context,
            Provider.of<DocumentProvider>(ctx, listen: false)
                .getDocumentsByFolderKey(folderName)[index],
            index,
            folderType);
      },
      itemCount: Provider.of<DocumentProvider>(ctx)
          .getDocumentsByFolderKey(folderName)
          .length,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
    );
  }

  Widget buildBodyForMobile(
      BuildContext context, String folderName, FolderType folderType) {
    return ListView.separated(
      itemBuilder: (context, index) => documentBody(
          context,
          Provider.of<DocumentProvider>(context)
              .getDocumentsByFolderKey(folderName)[index],
          index,
          folderType),
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: Provider.of<DocumentProvider>(context)
          .getDocumentsByFolderKey(folderName)
          .length,
    );
  }

  Widget documentBody(BuildContext context, Document document, int index,
      FolderType folderType) {
    return InkWell(
      onTap: () {
               Provider.of<DocumentProvider>(context,listen: false).onTabDocument(context, document, folderType);
        // do later
      },
      onDoubleTap: (){
        Provider.of<DocumentProvider>(context,listen: false).onDoubleTabDocument(context, document, folderType);

      },
      child: Column(
        children: [
          SizedBox(
            height: 125,
              width: 125,
              child: imageCoverDocumentBody(folderType, document.filePath)),
          Text(document.fileName??"new doc"),
        ],
      ),
    );
  }

  Widget imageCoverDocumentBody(FolderType folderType, String imagePath) {
    switch (folderType) {
      case FolderType.audio:
        return Image.asset(
          "assets/images/aduio.jpg",
          width: double.maxFinite,
          fit: BoxFit.contain,
        );
      case FolderType.video:
        return Image.asset(
          "assets/images/video.jpg",
          width: double.maxFinite,
          fit: BoxFit.cover,
        );
      case FolderType.txt:
        return Image.asset(
          "assets/images/txt.jpg",
          width: double.maxFinite,
          fit: BoxFit.cover,
        );
      case FolderType.exel:
        return Image.asset(
          "assets/images/exel.jpg",
          width: double.maxFinite,
          fit: BoxFit.cover,
        );
      case FolderType.image:
        return Image.file(
          File(imagePath),
          width: double.maxFinite,
          fit: BoxFit.cover,
        );
    }
  }
}
