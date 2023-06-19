import 'package:flutter/material.dart';
import 'dart:io';

import 'package:note/controller/note_provider.dart';
import 'package:note/controller/task_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../../core/const/task_const.dart';
import '../../../core/widget/dialog/task_dialog.dart';
import '../../../core/widget/my_text.dart';
import '../../../model/task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);
  static const routeName = "TaskScreen";

  @override
  Widget build(BuildContext context) {
    return Platform.isWindows
        ? buildBodyWindows(context)
        : buildBodyForMobile(context);
  }

  Widget buildBodyWindows(BuildContext context) {
    Map<String,double> chartCategory= Provider.of<TaskProvider>(context,listen: false).fullCategoryChart();
    Map<String,double> chartStatus= Provider.of<TaskProvider>(context,listen: false).fullStatusChart();
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: gridViewBody(context)),
      separatedBody(context),
      Expanded(child: chartBody(context,chartCategory,chartStatus))
    ]);
  }

  Widget gridViewBody(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 160,
      ),
      itemBuilder: (context, index) {
        return taskBody(
            context,
            Provider.of<TaskProvider>(context, listen: false)
                .taskBox
                .values
                .toList()[index],
            index);
      },
      itemCount: Provider.of<TaskProvider>(context).taskBox.length,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
    );
  }

  Widget separatedBody(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: 3,
      padding: const EdgeInsets.all(12.0),
    );
  }


  Widget chartBody(BuildContext context,Map<String,double> chartCategory,Map<String,double> chartStatus) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PieChart(
          dataMap: chartCategory,
          animationDuration: const Duration(seconds: 2),
          chartLegendSpacing: 16,
          chartRadius: MediaQuery.of(context).size.width /6,
          // colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          centerText: "Category",
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,

          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
        const SizedBox(height: 50,),
        PieChart(
          dataMap: chartStatus,
          animationDuration: const Duration(seconds: 2),
          chartLegendSpacing: 16,
          chartRadius: MediaQuery.of(context).size.width /6,
          // colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          centerText: "Status",
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,

          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
      ],
    );
  }

  Widget buildBodyForMobile(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => taskBody(
          context, Provider.of<NoteProvider>(context).getNotes()[index], index),
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: Provider.of<NoteProvider>(context).getNotes().length,
    );
  }

  Widget taskBody(BuildContext context, Task task, int index) {
    return InkWell(
      onTap: () {
        showDialog(context: context, builder: (context){
          return  TaskDialog(forEditing: true,task: task,

          );
        });
      },
      child: Card(elevation: 20, child: taskInfoBody(task)),
    );
  }

  Widget taskInfoBody(Task task) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(child: titleBody(task.name)),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Image.asset(mapTaskCategoryToAssetsPath(
                      convertStringToTaskCategory(task.category)))),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 4,
                child: taskSubInfo(task),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget taskSubInfo(Task task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        descriptionBody(task.description),
        const SizedBox(
          height: 15,
        ),
        dateBody(task.startDate, task.endDate),
        const SizedBox(
          height: 15,
        ),
        Align(alignment: Alignment.centerRight, child: statusBody(task.status))
      ],
    );
  }

  Widget dateBody(String startDate, String endDate) {
    return myText("$startDate - $endDate", color: Colors.grey, size: 10);
  }

  Widget titleBody(String title) {
    return SizedBox(
        height: 20, child: myText(title, size: 18, color: Colors.black));
  }

  Widget descriptionBody(String content) {
    return SizedBox(
        height: 20, child: myText(content, size: 14, color: Colors.black));
  }

  Widget statusBody(String status) {
    return Container(
        color: mapTaskStatusToColor(convertStringToTaskStatus(status)),
        padding: const EdgeInsets.all(8.0),
        child: myText(status, size: 10, color: Colors.black));
  }
}
