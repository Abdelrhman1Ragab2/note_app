
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/model/folders.dart';
import 'package:note/view/my_app.dart';
import 'package:provider/provider.dart';

import 'controller/bottom_provider.dart';
import 'controller/documents/audio_provider.dart';
import 'controller/folder_provider.dart';
import 'controller/menu_provider.dart';
import 'controller/note_provider.dart';
import 'model/document.dart';
import 'model/note.dart';

void main() async{

  await appInti();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomProvider>(create: (_)=>BottomProvider()),
            ChangeNotifierProvider<NoteProvider>(create: (_)=>NoteProvider()),
            ChangeNotifierProvider<MenuProvider>(create: (_)=>MenuProvider()),
            ChangeNotifierProvider<DocumentProvider>(create: (_)=>DocumentProvider()),
            ChangeNotifierProvider<FolderProvider>(create: (_)=>FolderProvider()),
            ChangeNotifierProvider<AudioProvider>(create: (_)=>AudioProvider()),
          ],

          child:const MyApp()
      )
  );


}

Future<void> appInti()async{
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(DocumentAdapter());
  Hive.registerAdapter(FolderAdapter());

  await Hive.openBox(AppConstant.noteBox);
  await Hive.openBox(AppConstant.fileBox);
  await Hive.openBox(AppConstant.folderBox);

}


