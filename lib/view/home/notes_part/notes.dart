
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/controller/note_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/widget/my_text.dart';
import '../../../model/note.dart';
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
    return Platform.isWindows?buildBodyWindows(context):
    buildBodyForMobile();
  }


  Widget buildBodyWindows(BuildContext ctx){
    return
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,

            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            mainAxisExtent: 200,

        ),
        itemBuilder: (context,index){
          return noteBody(Provider.of<NoteProvider>(ctx,listen: false).getNotes()[index],index);

        },
        itemCount: Provider.of<NoteProvider>(ctx).getNotes().length,
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
      );

  }

  Widget buildBodyForMobile(){
    return
      ListView.separated(itemBuilder: (context,index)=>noteBody(Provider.of<NoteProvider>(context).getNotes()[index],index),
              separatorBuilder: (_,__)=>const SizedBox(height: 5),
          itemCount: Provider.of<NoteProvider>(context).getNotes().length,
      );
  }

  Widget noteBody(Note note,int index){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, EditingPage.routeName,
            arguments: {
          "note":note,
        }

        );
      },
      child: Card(
        elevation: 20,

        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            getImageCoverBody(note),
            infoBody(note)
          ],),
      )
    );
  }

  Widget getImageCoverBody(Note note){
    if(note.isDefaultImage )
    {
      return Image.network(note.coverImageUrl,
        width: double.maxFinite,
        height: 200,
        fit: BoxFit.cover,
      );
    }
    else{

      return Image.file(File(note.coverImageUrl),
        width: double.maxFinite,
        height: 200,
        fit: BoxFit.cover,
      );
    }


  }

  Widget infoBody(Note note){
    return Container(
      height: 85,
      padding: const EdgeInsets.all(8.0),
      color: Colors.black54,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(flex: 1,
              child: dateBody(DateTime.now())),
          Expanded(
              flex:5,child: titleAndContentBody(note.title,note.content))
        ],
      ),
    );
  }

  Widget titleAndContentBody(String title,String content){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
    return  myText(title,size: 18);
  }

  Widget subTitleBody(String content){
    return myText(content,size: 14);
  }

}
