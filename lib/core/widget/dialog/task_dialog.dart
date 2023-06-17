import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/controller/task_provider.dart';
import 'package:provider/provider.dart';

import '../my_text.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 250, right: 250, top: 200, bottom: 150),
      child: AlertDialog(
          elevation: 20,
          title: const Text("New Task"),
          content: titleFieldBody(context),
          actionsAlignment: MainAxisAlignment.center,
          actions: actionBody(context)),
    );
  }

  List<Widget> actionBody(BuildContext context) {
    return [
      MaterialButton(
        padding: const EdgeInsets.all(12.0),
        elevation: 20,
        color: const Color.fromRGBO(204, 10, 10, 0.9019607843137255),
        onPressed: () async {
          await onSave(context);
          Navigator.pop(context);
        },
        child: myText(
          "save",
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      MaterialButton(
        padding: const EdgeInsets.all(12.0),
        elevation: 20,
        color: const Color.fromRGBO(80, 78, 78, 0.9019607843137255),
        onPressed: () {
          Navigator.pop(context);
        },
        child: myText(
          "Discard",
        ),
      ),
    ];
  }

  Widget contentBody(BuildContext context){
    return Column(
      children: [
        titleFieldBody(context),
        const SizedBox(height: 10,),
        descriptionFieldBody(context),
        Row()
      ],
    );
  }

  Widget titleFieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider.of<TaskProvider>(context).titleController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Task title",
          )),
    );
  }
  Widget descriptionFieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider.of<TaskProvider>(context).descriptionController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Task description",
          )),
    );
  }

  Future<void> onSave(BuildContext context) async {
    Provider.of<DSummaryProvider>(context, listen: false).crateDSummary(
        Provider.of<DSummaryProvider>(context,listen: false).dialogController.text,
        day,
        month);

  }
}

