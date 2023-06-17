import 'package:flutter/cupertino.dart';
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

  String startDate="start date";
  String endDate="end date";

  Future<void> crateTask({
    required String name,
    required String description,
    required String category,
    required String status,
    required String startDate,
    required String endDate,
  }) async {
    int key = await taskBox.add(null);
    Task task = Task(
        id: key,
        name: name,
        description: description,
        category: category,
        startDate: startDate,
        endDate: endDate,
        status: status);
    await taskBox.put(key, task);
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  Future<void> clearTasks() async {
    await taskBox.clear();
    notifyListeners();
  }

  Future<void> deleteTaskByKey(int key) async {
    await taskBox.delete(key);
    notifyListeners();
  }

  Future<void> updateTask(Task newTask) async {
    await taskBox.put(newTask.id, newTask);
    notifyListeners();
  }

  changeTaskCategory(TaskCategory newTaskCategory) {
    taskCategory = newTaskCategory;
    notifyListeners();
  }

  changeTasStatus(TaskStatus newTaskStatus) {
    taskStatus = newTaskStatus;
    notifyListeners();
  }

  changeStartDate(String newDate){
    startDate=newDate;
    notifyListeners();
  }


  changeEndDate(String newDate){
    endDate=newDate;
    notifyListeners();
  }
}
