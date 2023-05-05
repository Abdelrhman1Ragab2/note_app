import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/controller/document_provider.dart';
import 'package:note/controller/folder_provider.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:provider/provider.dart';

import '../my_text.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String contentMessage;
  final int documentId;

  const DeleteDialog(
      {Key? key, required this.title, required this.contentMessage,required this.documentId})
      : super(key: key);

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
          title: Text(title),
          content: contentBody(context),
          actionsAlignment: MainAxisAlignment.center,
          actions: actionBody(context)
      ),
    );
  }

  List<Widget> actionBody(BuildContext context){
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
          "Delete",
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

  Widget contentBody(BuildContext context) {
    return Text(contentMessage);
  }

  Future<void> onSave(BuildContext context)async{
   await Provider.of<DocumentProvider>(context,listen: false).deleteDocumentByKey(documentId);

  }




}
