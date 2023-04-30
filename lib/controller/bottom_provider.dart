import 'package:flutter/cupertino.dart';

class BottomProvider with ChangeNotifier{

  int currentIndex=1;

  void changeIndex(int index){
    currentIndex=index;
    notifyListeners();
  }


}