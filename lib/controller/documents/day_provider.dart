import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../core/const/app_constant.dart';
import '../../model/day_summary.dart';

class DSummaryProvider with ChangeNotifier{


  Box dSummaryBox = Hive.box(AppConstant.dSummaryBox);
  TextEditingController dialogController=TextEditingController();
  Future<void> crateDSummary(String text, int day ,int month) async {
    int key = await dSummaryBox.add(null);
    DSummary dSummary = DSummary(text:text,day:day ,month: month );
    await dSummaryBox.put(key, dSummary);
    dialogController.clear();
    notifyListeners();
  }

  Future<void> clearYearInfo() async {
    await dSummaryBox.clear();
    notifyListeners();
  }



  Future<void> deleteDSummaryByKey(int key) async {
    await dSummaryBox.delete(key);
    notifyListeners();
  }

}