import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          content: fieldBody(context),
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

  Widget fieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider.of<DSummaryProvider>(context).dialogController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "write day summary",
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

