
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/controller/folder_provider.dart';
import 'package:note/core/widget/dialog/document_dialog.dart';
import 'package:note/view/home/notes_part/editing.dart';
import 'package:provider/provider.dart';

import 'dialog/task_dialog.dart';

class FloatingFunction {


   Future<void>doOperation(int index,BuildContext context)async{
    switch(index){
    // we don't need FloatingButton in day summary screen so we delete case:0
      case 1:
        noteButton(context);
        break;
      case 2:
        taskButton(context);
        break;
      case 3:
        await folderButton(context);
        break;


    }
  }
  void overViewButton(BuildContext context){
  }

  void noteButton(BuildContext context){
    Navigator.pushNamed(context, EditingPage.routeName,arguments: {"note":null});

  }
  void taskButton(BuildContext context){
    showDialog(context: context, builder: (context){
      return const TaskDialog(forEditing: false,

      );
    });

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