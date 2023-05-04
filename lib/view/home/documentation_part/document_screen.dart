import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:note/model/document.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(title: myText(folderName),centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
          onPressed: ()async{

              String? filePath = await  Provider.of<DocumentProvider>(context,listen: false).getFilePath();

              if(filePath!=null ){
                await Provider.of<DocumentProvider>(context,listen: false).putDocument(filePath,folderName);
              }
              else{
                print("file not select");
            }

          },child:const Icon(Icons.upload)
      ),
      body: Platform.isWindows
          ? buildBodyWindows(context, folderName)
          : buildBodyForMobile(context, folderName),
    );
  }

  Widget buildBodyWindows(BuildContext ctx, String folderName) {
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
            index);
      },
      itemCount: Provider.of<DocumentProvider>(ctx)
          .getDocumentsByFolderKey(folderName)
          .length,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
    );
  }

  Widget buildBodyForMobile(BuildContext context, String folderKey) {
    return ListView.separated(
      itemBuilder: (context, index) => documentBody(
          context,
          Provider.of<DocumentProvider>(context)
              .getDocumentsByFolderKey(folderKey)[index],
          index),
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: Provider.of<DocumentProvider>(context)
          .getDocumentsByFolderKey(folderKey)
          .length,
    );
  }

  Widget documentBody(BuildContext context, Document document, int index) {
    return InkWell(
        onTap: () {
          // do later
        },
        child: Card(elevation: 20, child: infoBody(context, document)));
  }

  Widget infoBody(BuildContext context, Document document) {
    return Container(
        height: 85,
        padding: const EdgeInsets.all(8.0),
        color: Theme.of(context).secondaryHeaderColor,
        child: Expanded(flex: 5, child: titleAndContentBody(document)));
  }

  Widget titleAndContentBody(Document document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleBody(document.folderNamePath),
        subTitleBody(document.filePath),
      ],
    );
  }

  Widget titleBody(String title) {
    return myText(title, size: 18);
  }

  Widget subTitleBody(String content) {
    return myText(content, size: 14);
  }
}
