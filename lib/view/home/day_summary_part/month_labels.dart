import 'package:flutter/material.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/core/widget/my_text.dart';

import 'day_labels.dart';

class MonthLabels extends StatelessWidget {
  const MonthLabels({Key? key}) : super(key: key);
  static const routeName = "MonthLabels";

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) =>
            listBody(context, AppConstant.monthLabel.keys.toList()[index],
                AppConstant.monthLabel.values.toList()[index], index),
        separatorBuilder: (_, __) => const SizedBox(height: 10,),
        itemCount: 12);
  }

  Widget listBody(BuildContext context, String month, int dayNumbers,
      int index) {
    bool currentMonth = index + 1 == DateTime
        .now()
        .month;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DayLabels.routeName, arguments: {
          "DayNumbers": dayNumbers,
          "MonthName": month,
          "MonthNumber": index + 1,
        }
        );
      },
      child: Card(
        color: currentMonth ? Colors.grey : Theme
            .of(context)
            .secondaryHeaderColor,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: myText(month, size: 20),
        ),
      ),
    );
  }
}
