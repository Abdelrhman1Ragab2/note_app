import 'package:hive/hive.dart';
part 'document.g.dart';



@HiveType(typeId: 1)
class Document extends HiveObject{

  @HiveField(0)
  final String filePath;
  @HiveField(1)
  final String folderName;
  @HiveField(2)
  final int id;


  Document({required this.filePath,required this.folderName,required this.id});





}