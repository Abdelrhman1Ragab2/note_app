import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/controller/folder_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/const/folder_type.dart';
import '../../../core/widget/my_text.dart';
import '../../../model/folders.dart';
import 'document_screen.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({Key? key}) : super(key: key);
  static const routeName="FolderScreen";


  @override
  Widget build(BuildContext context) {
    return Platform.isWindows ? buildBodyWindows(context) :
    buildBodyForMobile(context);
  }



  Widget buildBodyWindows(BuildContext ctx){
    return
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,

          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          mainAxisExtent: 150,

        ),
        itemBuilder: (context,index){
          return folderBody(context,Provider.of<FolderProvider>(ctx,listen: false).getFolders()[index],index);

        },
        itemCount: Provider.of<FolderProvider>(ctx).getFolders().length,
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
      );

  }

  Widget buildBodyForMobile(BuildContext context){
    return
      ListView.separated(itemBuilder: (context,index)=>folderBody(context,Provider.of<FolderProvider>(context).getFolders()[index],index),
        separatorBuilder: (_,__)=>const SizedBox(height: 5),
        itemCount: Provider.of<FolderProvider>(context).getFolders().length,
      );
  }

  Widget folderBody(BuildContext context,Folder folder,int index){
    return InkWell(
        onTap: (){
          Navigator.pushNamed(context, DocumentationScreen.routeName,arguments: {
            'folderName':folder.name,
            "folderType":convertStringToFolderType(folder.type),

          });
          // do later
        },
        child: Card(
            elevation: 20,
            child: Stack(
              alignment: Alignment.bottomCenter,
                children:[
                  imageCoverBody(),
                  folderNameBody(context,folder)
                ]
            )

        )
    );
  }
  Widget imageCoverBody() {
    return Image.asset("assets/images/folder.jpg",
      width: double.maxFinite,
      fit: BoxFit.cover,
    );
  }



  Widget folderNameBody(BuildContext context,Folder folder){
    return Container(
      width: double.maxFinite,
        height: 50,
        padding: const EdgeInsets.all(8.0),
        color: Colors.black54,
        child:
        Expanded(
            flex:5,child: titleAndContentBody(folder))
    );
  }

  Widget titleAndContentBody(Folder folder){
    return titleBody(folder.name);
  }


  Widget titleBody(String title){
    return  myText(title,size: 18);
  }


}

