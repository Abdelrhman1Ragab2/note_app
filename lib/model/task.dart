import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 4)
class Task extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String startDate;
  @HiveField(5)
  final String endDate;
  @HiveField(6)
  final String status;

  Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.startDate,
      required this.endDate,
      required this.status});
}
