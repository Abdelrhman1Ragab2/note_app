import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note/core/app_constant.dart';
import 'package:note/model/note.dart';
import 'package:note/view/my_app.dart';
import 'package:provider/provider.dart';

import 'controller/bottom_provider.dart';
import 'controller/note_provider.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(AppConstant.noteBox);
  print("i done ");

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomProvider>(create: (_)=>BottomProvider()),
            ChangeNotifierProvider<NoteProvider>(create: (_)=>NoteProvider()),
          ],

          child:const MyApp()
      )
  );


}


