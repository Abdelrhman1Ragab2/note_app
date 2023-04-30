import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/note_provider.dart';
import '../../core/widget/my_text.dart';
import '../../model/note.dart';

class EditingPage extends StatelessWidget {
  EditingPage({Key? key}) : super(key: key);
  static const routeName = "EditingPage";
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Note? note = routArg["note"];

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<NoteProvider>(context, listen: false)
              .putNoteItem(
              content: contentController.text,
            title: titleController.text
          );
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(18.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              infoBody(),
              const SizedBox(
                height: 10,
              ),
              myListTitle()
            ],
          ),
        ),
      ),
    );
  }

  Widget infoBody() {
    return Row(
      children: [
        myText(DateFormat.yMMMEd().format(DateTime.now())),
        const SizedBox(width: 20,),
        myText(DateFormat.jm().format(DateTime.now())),
      ],
    );
  }

  Widget myListTitle() {
    return Column(
      children: [
        TextFormField(
          controller: titleController,

          style: const TextStyle(color: Colors.white,fontSize: 26),
          decoration: InputDecoration(
              border:  const OutlineInputBorder( borderSide: BorderSide(color:  Color.fromARGB(
                  201, 12, 23, 23),
              )),

              hintStyle: const TextStyle(color: Colors.grey),
              hintText:
              titleController.text.isEmpty ? "title" : titleController.text),
        ),
        const SizedBox(height: 10,),
        TextFormField(
            style: const TextStyle(color: Colors.white,fontSize: 26),
            minLines: 10,
            maxLines: 250,
            controller: contentController,
            decoration: InputDecoration(
              border: const OutlineInputBorder( borderSide: BorderSide(color:  Color.fromARGB(
                  201, 12, 23, 23),
              )),
              hintStyle: const TextStyle(color: Colors.grey),
              hintText:
              contentController.text.isEmpty ? "please write beautiful something from your amazing thinking"
                  : contentController.text,

            )
        ),
      ],

    );
  }
}
