import 'package:flutter/material.dart';
import 'dart:io';

import 'package:note/controller/note_provider.dart';
import 'package:note/controller/task_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/const/task_const.dart';
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
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: gridViewBody(context)),
      separatedBody(context),
      Expanded(child: chartBody(context))
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


  Widget chartBody(BuildContext context) {
    return Container(

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
      onTap: () {},
      child: Card(elevation: 20, child: infoBody(task)),
    );
  }

  Widget infoBody(Task task) {
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
                child: taskInfo(task),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget taskInfo(Task task) {
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
