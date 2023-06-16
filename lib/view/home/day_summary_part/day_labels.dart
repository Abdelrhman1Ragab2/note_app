import 'package:flutter/material.dart';
import 'package:note/controller/documents/day_provider.dart';
import 'package:note/core/widget/my_text.dart';
import 'package:note/model/day_summary.dart';
import 'package:provider/provider.dart';

import '../../../core/widget/dialog/day_summary_dialog.dart';

class DayLabels extends StatelessWidget {
  const DayLabels({Key? key}) : super(key: key);
  static const routeName = "DayLabels";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int dayNumbers = routeArg["DayNumbers"];
    String month = routeArg["MonthName"];
    int monthNumber = routeArg["MonthNumber"];
    List<dynamic> dSummaryList=Provider.of<DSummaryProvider>(context).dSummaryBox.values.toList();

    return Scaffold(
        appBar: AppBar(
          title: myText(month),
          centerTitle: true,
        ),
        body: buildBody(context, dayNumbers, monthNumber,dSummaryList));
  }

  Widget buildBody(BuildContext context, int dayNumbers, int monthNumber,dSummaryList) {
    return ListView.separated(
        itemBuilder: (context, index) =>
            listBody(context, index + 1, monthNumber,dSummaryList),
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: dayNumbers);
  }

  Widget listBody(BuildContext context, int day, int monthNumber,dSummaryList) {
    bool currentDay =
        day == DateTime.now().day && monthNumber == DateTime.now().month;
    DSummary? dSummary=filteringDaySummary(context,dSummaryList,day,monthNumber);
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return DSummaryDialog(
                day: day,
                month: monthNumber,
              );
            });
      },
      child: Card(
          color:
              currentDay ? Colors.grey : Theme.of(context).secondaryHeaderColor,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                myText(day.toString(), size: 20),
                const SizedBox(width: 20,),
                dSummary!=null?
                myText(dSummary.text,size: 22):const SizedBox()
              ],
            ),
          )),
    );
  }

  DSummary? filteringDaySummary(BuildContext context,List<dynamic> dSummary,int day,int month){
    DSummary? newDaySummary;
    for (var element in dSummary) {
      if(element.day==day && element.month==month) {
        newDaySummary= element;
        break;
      }

    }
    if(newDaySummary!=null){
      Provider.of<DSummaryProvider>(context,listen: false).dialogController.text=newDaySummary.text;
    }
    return newDaySummary;

  }
}
