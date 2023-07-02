import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/menu_model.dart';

class MenuProvider with ChangeNotifier{

  int menusSelectedIndex=1;
  void changeMenuIndex(int index){
    menusSelectedIndex=index;
   notifyListeners();
  }
  List<MenuModel> menus=[
    MenuModel(title: "Day Summary", icon: Icons.summarize_outlined),
    MenuModel(title: "Notes", icon: Icons.notes,),
    MenuModel(title: "Task", icon: Icons.task_alt,),
    MenuModel(title: "Documentation", icon: Icons.file_open,),


  ];



}