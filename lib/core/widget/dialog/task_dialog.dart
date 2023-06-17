import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/controller/task_provider.dart';
import 'package:provider/provider.dart';

import '../../const/task_const.dart';
import '../my_text.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 150, right: 150, top: 50, bottom: 50),
      child: AlertDialog(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          elevation: 20,
          title: myText("New Task", size: 22),
          content: contentBody(context),
          actionsAlignment: MainAxisAlignment.center,
          actions: actionBody(context)),
    );
  }

  List<Widget> actionBody(BuildContext context) {
    return [
      MaterialButton(
        padding: const EdgeInsets.all(12.0),
        elevation: 20,
        color: const Color.fromRGBO(204, 10, 10, 0.9019607843137255),
        onPressed: () async {
          await onSave(context);
        },
        child: myText(
          "save",
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      MaterialButton(
        padding: const EdgeInsets.all(12.0),
        elevation: 20,
        color: const Color.fromRGBO(80, 78, 78, 0.9019607843137255),
        onPressed: () {
          Navigator.pop(context);
        },
        child: myText(
          "Discard",
        ),
      ),
    ];
  }

  Widget contentBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          titleFieldBody(context),
          const SizedBox(
            height: 10,
          ),
          descriptionFieldBody(context),
          const SizedBox(
            height: 10,
          ),
          taskCategoryBody(context),
          const SizedBox(
            height: 10,
          ),
          taskStatusBody(context),
          const SizedBox(
            height: 10,
          ),
          dateBody(context)
        ],
      ),
    );
  }

  Widget titleFieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider
              .of<TaskProvider>(context)
              .titleController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Task title",
          )),
    );
  }

  Widget descriptionFieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider
              .of<TaskProvider>(context)
              .descriptionController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Task description",
          )),
    );
  }

  Widget taskCategoryBody(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(flex: 1, child: Text("Category: ")),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                          convertTaskCategoryToString(TaskCategory.programing)),
                      leading: Radio(
                        value: TaskCategory.programing,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskCategory,
                        onChanged: (TaskCategory? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTaskCategory(value!);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          convertTaskCategoryToString(TaskCategory.language)),
                      leading: Radio(
                        value: TaskCategory.language,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskCategory,
                        onChanged: (TaskCategory? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTaskCategory(value!);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title:
                      Text(convertTaskCategoryToString(TaskCategory.work)),
                      leading: Radio(
                        value: TaskCategory.work,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskCategory,
                        onChanged: (TaskCategory? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTaskCategory(value!);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(convertTaskCategoryToString(
                          TaskCategory.technological)),
                      leading: Radio(
                        value: TaskCategory.technological,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskCategory,
                        onChanged: (TaskCategory? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTaskCategory(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget taskStatusBody(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(flex: 1, child: Text("Status: ")),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title:
                      Text(convertTaskStatusToString(TaskStatus.progress)),
                      leading: Radio(
                        value: TaskStatus.progress,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskStatus,
                        onChanged: (TaskStatus? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTasStatus(value!);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title:
                      Text(convertTaskStatusToString(TaskStatus.pending)),
                      leading: Radio(
                        value: TaskStatus.pending,
                        groupValue:
                        Provider
                            .of<TaskProvider>(context)
                            .taskStatus,
                        onChanged: (TaskStatus? value) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .changeTasStatus(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dateBody(BuildContext context) {
    return Card(
      elevation: 20,
      child: Row(
        children: [
          Expanded(child: startDateBody(context)),
          Expanded(child: endDateBody(context))
        ],
      ),
    );
  }

  Widget startDateBody(BuildContext context) {
    return ListTile(
      title: Text(Provider
          .of<TaskProvider>(context, listen: false)
          .startDate),
      leading: const Icon(Icons.date_range),
      onTap: () async {
        DateTime? dateTime = await timePicker(context);
        if (dateTime != null) {
          Provider.of<TaskProvider>(context, listen: false)
              .changeStartDate(DateFormat.yMMMEd().format(dateTime));
        }
      },
    );
  }

  Widget endDateBody(BuildContext context) {
    return ListTile(
      title: Text(Provider
          .of<TaskProvider>(context, listen: false)
          .endDate),
      leading: const Icon(Icons.date_range),
      onTap: () async {
        DateTime? dateTime = await timePicker(context);
        if (dateTime != null) {
          Provider.of<TaskProvider>(context, listen: false)
              .changeEndDate(DateFormat.yMMMEd().format(dateTime));
        }
      },
    );
  }

  Future<DateTime?> timePicker(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+3));
    return dateTime;
  }

  Future<void> onSave(BuildContext context) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

   await Provider.of<TaskProvider>(context).crateTask(
        name: taskProvider.titleController.text,
        description: taskProvider.descriptionController.text,
        category: convertTaskCategoryToString(taskProvider.taskCategory),
        status: convertTaskStatusToString(taskProvider.taskStatus),
        startDate: taskProvider.startDate,
        endDate: taskProvider.endDate);
  }
}
