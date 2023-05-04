import 'package:hive/hive.dart';
part 'document.g.dart';



@HiveType(typeId: 1)
class Document extends HiveObject{

  @HiveField(0)
  final String filePath;
  @HiveField(1)
  final String folderNamePath;
  @HiveField(2)
  final int id;


  Document({required this.filePath,required this.folderNamePath,required this.id});





}