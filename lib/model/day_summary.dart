import 'package:hive/hive.dart';

part 'day_summary.g.dart';

@HiveType(typeId: 3)
class DSummary extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  int day;
  @HiveField(2)
  int month;

  DSummary({required this.text, required this.day, required this.month});
}
