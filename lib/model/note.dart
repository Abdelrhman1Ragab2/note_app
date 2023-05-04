import 'package:hive/hive.dart';

part 'note.g.dart';
@HiveType(typeId: 0)
class Note extends HiveObject{



  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String lastUpdate;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String coverImageUrl;
  @HiveField(5)
  final bool isDefaultImage;

   Note(
      {required this.id,required this.title, required this.isDefaultImage, required this.lastUpdate,
        required this.content, required this.coverImageUrl});


}