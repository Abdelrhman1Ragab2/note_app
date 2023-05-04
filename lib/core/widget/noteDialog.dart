import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:note/core/widget/my_text.dart';
import 'package:provider/provider.dart';

import '../../controller/note_provider.dart';

class NoteDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool isNewNote;
  final String noteId;

  const NoteDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.isNewNote,
      required this.noteId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 330, right: 330, top: 300, bottom: 200),
        child: Dialog(
          child: Card(
            color: Theme.of(context).primaryColor.withGreen(30),
            elevation: 20,
            child: dialogBody(context),
          ),
        ),
      ),
    );
  }

  Widget dialogBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        messageBody(),
        const SizedBox(
          height: 20,
        ),
        buttonsBody(context)
      ],
    );
  }

  Widget messageBody() {
    return myText("Do you want save the changes !");
  }

  Widget buttonsBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(12.0),
          elevation: 20,
          color: Colors.grey,
          onPressed: () async {
            await onSave(context);
          },
          child: myText("Save", color: Colors.black),
        ),
        const SizedBox(
          width: 25,
        ),
        MaterialButton(
          padding: const EdgeInsets.all(12.0),
          elevation: 20,
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: myText("Discard", color: Colors.black),
        ),
      ],
    );
  }

  onSave(BuildContext context) async {
    bool isDefault = Provider.of<NoteProvider>(context,listen: false).isDefaultImage;
    String newImage = Provider.of<NoteProvider>(context,listen: false).newImageUrl;
    if (isNewNote) {
      await Provider.of<NoteProvider>(context, listen: false)
          .putNoteItem(content:content , title: title);
    } else {
      await Provider.of<NoteProvider>(context, listen: false).updateNoteByKey(
          key: noteId,
          newTitle: title,
          newContent: content,
          newImage: isDefault ? AppConstant.defaultImageURl : newImage,
          isDefaultImg: isDefault);
    }
    Navigator.pop(context);
  }


}
