import 'package:flutter/cupertino.dart';
import 'package:note/view/home/overview_part/overview_screen.dart';

import '../view/home/day_summary_part/day_summary.dart';
import '../view/home/documentation_part/folders_screen.dart';
import '../view/home/notes_part/notes.dart';
import '../view/home/plan_part/plans.dart';

class BottomProvider with ChangeNotifier{

  int currentIndex=2;
  List<Widget> homeScreens = const [OverView(),DaySummary(), Notes(), Plans(),FolderScreen()];

  void changeIndex(int index){
    currentIndex=index;
    notifyListeners();
  }


}