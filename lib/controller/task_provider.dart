import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/core/const/task_const.dart';
import 'package:note/model/task.dart';


class TaskProvider with ChangeNotifier {
  Box taskBox = Hive.box(AppConstant.taskBox);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskCategory taskCategory = TaskCategory.programing;
  TaskStatus taskStatus = TaskStatus.progress;

  String startDate = "start date";
  String endDate = "end date";

  Future<void> crateTask() async {
    int key = await taskBox.add(null);
    final Task myTask = storeTaskInfo(key);
    await taskBox.put(key, myTask);
    resetDefaultValue();
    notifyListeners();
  }

  resetDefaultValue() {
    titleController.clear();
    descriptionController.clear();
    taskCategory = TaskCategory.programing;
    taskStatus = TaskStatus.progress;

    startDate = "start date";
    endDate = "end date";
  }

  Task storeTaskInfo(int key) {
    Task task = Task(
        id: key,
        name: titleController.text,
        description: descriptionController.text,
        category: convertTaskCategoryToString(taskCategory),
        startDate: startDate,
        endDate: endDate,
        status: convertTaskStatusToString(taskStatus));
    return task;
  }

  Future<void> clearTasks() async {
    await taskBox.clear();
    notifyListeners();
  }

  Future<void> deleteTaskByKey(int key) async {
    await taskBox.delete(key);
    notifyListeners();
  }

  Future<void> updateTask(int key) async {
    final Task newTask = storeTaskInfo(key);
    await taskBox.put(key, newTask);
    resetDefaultValue();
    notifyListeners();
  }

  changeTaskCategory(TaskCategory newTaskCategory) {
    print("newTaskCategory ${convertTaskCategoryToString(taskCategory)}");
    taskCategory = newTaskCategory;
    notifyListeners();
  }

  changeTasStatus(TaskStatus newTaskStatus) {
    taskStatus = newTaskStatus;
    notifyListeners();
  }

  changeStartDate(String newDate) {
    startDate = newDate;
    notifyListeners();
  }

  changeEndDate(String newDate) {
    endDate = newDate;
    notifyListeners();
  }

  Map<String, double> fullCategoryChart() {
    List<dynamic> chartList = taskBox.values.toList();
    List<double> outputPercent = [0, 0, 0, 0];
    for (var element in chartList) {
      if (element.category == "language") {
        outputPercent[0] = outputPercent[0] + 1;
      } else if (element.category == "programing") {
        outputPercent[1] = outputPercent[1] + 1;
      } else if (element.category == "religious ") {
        outputPercent[2] = outputPercent[2] + 1;
      } else if (element.category == "work") {
        outputPercent[3] = outputPercent[3] + 1;
      }
    }
    final Map<String, double> categoryChart = {
      'language': outputPercent[0],
      'programing': outputPercent[1],
      'religious ': outputPercent[2],
      'work': outputPercent[3],
    };

    return categoryChart;
  }

  Map<String, double> fullStatusChart() {
    List<dynamic> chartList = taskBox.values.toList();
    List<double> outputPercent = [0, 0, 0];
    for (var element in chartList) {
      if (element.status == "progress") {
        outputPercent[0] = outputPercent[0] + 1;
      } else if (element.status == "pending") {
        outputPercent[1] = outputPercent[1] + 1;
      } else if (element.status == "finished") {
        outputPercent[2] = outputPercent[2] + 1;
      }
    }
    final Map<String, double> statusChart = {
      'progress': outputPercent[0],
      'pending': outputPercent[1],
      'finished': outputPercent[2],
    };

    return statusChart;
  }

  Future<void>doEditingOperation({
    required String name,
    required String description,
    required String category,
    required String status,
    required String myStartDate,
    required String myEndDate,
  }) async{
    titleController.text = name;
    descriptionController.text = description;
    taskStatus = convertStringToTaskStatus(status);
    taskCategory = convertStringToTaskCategory(category);
    startDate = myStartDate;
    endDate = myEndDate;
    notifyListeners();
  }
}
