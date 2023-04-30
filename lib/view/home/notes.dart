import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note/controller/note_provider.dart';
import 'package:provider/provider.dart';

import '../../core/widget/my_text.dart';
import '../../model/note.dart';
import 'editing.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);
  static const routeName="Notes";

  @override
  State<Notes> createState() => _NotesState();
}
class _NotesState extends State<Notes> {
  @override

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody(){
    return
      ListView.separated(itemBuilder: (context,index)=>noteBody(Provider.of<NoteProvider>(context).getNotes()[index]),
              separatorBuilder: (_,__)=>const SizedBox(height: 5),
          itemCount: Provider.of<NoteProvider>(context).getNotes().length,
      );
  }

  Widget noteBody(Note note){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, EditingPage.routeName,arguments: {"note":note});
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
        Image.network(note.coverImageUrl,
          width: double.maxFinite,
             height: 300,
            fit: BoxFit.fitWidth,
        ),
          infoBody(note)
        ],)
    );
  }

  Widget infoBody(Note note){
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black54,
      child: Row(
        children: [
          dateBody(DateTime.now()),
          const SizedBox(width: 20,),
          titleAndContentBody(note.title,note.content)
        ],
      ),
    );
  }

  Widget titleAndContentBody(String title,String content){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleBody(title),
        subTitleBody(content),
      ],
    );
  }

  Widget dateBody(DateTime dateTime){
    return SizedBox(
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myText(DateFormat.E().format(dateTime)),
          myText(dateTime.day.toString(),size: 20),
          myText(DateFormat.MMMM().format(dateTime)),
        ],
      ),
    );
  }

  Widget titleBody(String title){
    return myText(title,size: 26);
  }

  Widget subTitleBody(String content){
    return myText(content,size: 20);
  }




}
