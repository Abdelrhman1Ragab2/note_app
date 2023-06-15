import 'package:flutter/material.dart';
import 'package:note/core/widget/my_text.dart';

class DayLabels extends StatelessWidget {
  const DayLabels({Key? key}) : super(key: key);
  static const routeName = "DayLabels";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int dayNumbers = routeArg["DayNumbers"];
    String month = routeArg["MonthName"];
    int monthNumber= routeArg["MonthNumber"];

    return Scaffold(
        appBar: AppBar(
          title: myText(month),
          centerTitle: true,
        ),
        body: buildBody(context, dayNumbers,monthNumber));
  }

  Widget buildBody(BuildContext context, int dayNumbers,int monthNumber) {
    return ListView.separated(
        itemBuilder: (context, index) => listBody(context, index + 1,monthNumber),
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: dayNumbers);
  }

  Widget listBody(BuildContext context, int index,int monthNumber) {
    bool currentDay = index == DateTime.now().day && monthNumber==DateTime.now().month;
    return InkWell(
      onTap: () {},
      child: Card(
          color:
              currentDay ? Colors.grey : Theme.of(context).secondaryHeaderColor,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: myText(index.toString(), size: 20),
          )),
    );
  }
}
