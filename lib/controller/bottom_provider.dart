import 'package:flutter/cupertino.dart';
import 'package:note/view/home/task/tasks.dart';

import '../view/home/day_summary_part/month_labels.dart';
import '../view/home/documentation_part/folders_screen.dart';
import '../view/home/notes_part/notes.dart';

class BottomProvider with ChangeNotifier{

  int currentIndex=1;
  List<Widget> homeScreens = const [MonthLabels(), Notes(), TaskScreen(),FolderScreen()];

  void changeIndex(int index){
    currentIndex=index;
    notifyListeners();
  }


}