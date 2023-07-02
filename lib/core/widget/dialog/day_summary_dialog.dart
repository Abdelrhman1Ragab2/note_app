import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/model/day_summary.dart';
import 'package:provider/provider.dart';

import '../../../controller/documents/day_provider.dart';
import '../my_text.dart';

class DSummaryDialog extends StatefulWidget {
  final int day;
  final int month;
  final DSummary? dSummary;

  const DSummaryDialog(
      {Key? key, required this.day, required this.month, this.dSummary})
      : super(key: key);

  @override
  State<DSummaryDialog> createState() => _DSummaryDialogState();
}

class _DSummaryDialogState extends State<DSummaryDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.dSummary != null) {
        doInitOperation(context);
      }
    });
  }

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
          title: Text(DateFormat.yMMMEd().format(DateTime.now())),
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
          controller: Provider
              .of<DSummaryProvider>(context)
              .dialogController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "write day summary",
          )),
    );
  }

  Future<void> onSave(BuildContext context) async {
    if (widget.dSummary != null) {
      DSummary dSummary = DSummary(text: Provider
          .of<DSummaryProvider>(context,listen: false)
          .dialogController
          .text, day: widget.day, month: widget.month, id: widget.dSummary!.id);
      Provider.of<DSummaryProvider>(context, listen: false).updateDaySummary(
          dSummary);
    }
    else {
      Provider.of<DSummaryProvider>(context, listen: false).crateDSummary(
          Provider
              .of<DSummaryProvider>(context, listen: false)
              .dialogController
              .text,
          widget.day,
          widget.month);
    }
  }

  doInitOperation(BuildContext context) async {
    await Provider.of<DSummaryProvider>(context, listen: false)
        .doEditingOperation(daySummary: widget.dSummary!.text);
  }
}
