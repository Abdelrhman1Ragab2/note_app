import 'package:hive/hive.dart';

part 'folders.g.dart';

@HiveType(typeId: 2)
class Folder extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;

  Folder({required this.id, required this.name, required this.type});
}
