
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/controller/folder_provider.dart';
import 'package:note/core/widget/document_dialog.dart';
import 'package:note/view/home/notes_part/editing.dart';
import 'package:provider/provider.dart';

class FloatingFunction {


   Future<void>doOperation(int index,BuildContext context)async{
    switch(index){
      case 0:
        overViewButton(context);
        break;
      case 1:
        daySummaryButton(context);
        print("d");

        break;
      case 2:
        noteButton(context);
        print("n");

        break;
      case 3:
        planButton(context);
        print("p");
        break;
      case 4:
        await folderButton(context);
        print("iam in folder");
        break;


    }
  }
  void overViewButton(BuildContext context){
  }
  void daySummaryButton(BuildContext context){

  }
  void noteButton(BuildContext context){
    Navigator.pushNamed(context, EditingPage.routeName,arguments: {"note":null});

  }
  void planButton(BuildContext context){

  }

  Future<void> folderButton(BuildContext context)async{
     showDialog(context: context, builder: (context){
       return const FolderDialog(
           title: "New folder",
           contentMessage: "folder name",
       );
     });
  }



}