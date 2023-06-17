enum TaskCategory { programing, language, technological, work }

String convertTaskCategoryToString(TaskCategory taskCategory) {
  switch (taskCategory) {
    case TaskCategory.language:
      return "language";
    case TaskCategory.programing:
      return "programing";
    case TaskCategory.technological:
      return "technological";
    case TaskCategory.work:
      return "work";
  }
}

TaskCategory? convertStringToTaskCategory(String string) {
  switch (string) {
    case "language":
      return TaskCategory.language;
    case "programing":
      return TaskCategory.programing;
    case "technological":
      return TaskCategory.technological;
    case "work":
      return TaskCategory.work;
  }
  return null;
}

enum TaskStatus { progress, pending, finished }

String convertTaskStatusToString(TaskStatus taskStatus) {
  switch (taskStatus) {
    case TaskStatus.progress:
      return "progress";
    case TaskStatus.pending:
      return "pending";
    case TaskStatus.finished:
      return "finished";
  }
}

TaskStatus? convertStringToTaskStatus(String string) {
  switch (string) {
    case "progress":
      return TaskStatus.progress;
    case "pending":
      return TaskStatus.pending;
    case "finished":
      return TaskStatus.finished;
  }
  return null;
}
