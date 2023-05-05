import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/controller/folder_provider.dart';
import 'package:note/core/const/folder_type.dart';
import 'package:provider/provider.dart';

import '../my_text.dart';

class FolderDialog extends StatelessWidget {
  final String title;
  final String contentMessage;

  const FolderDialog(
      {Key? key, required this.title, required this.contentMessage})
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
        color: const Color.fromRGBO(10, 18, 60, 0.9),
        onPressed: () async {
          await onSave(context);
          Navigator.pop(context);
        },
        child: myText(
          "Save",
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      MaterialButton(
        padding: const EdgeInsets.all(12.0),
        elevation: 20,
        color: const Color.fromRGBO(10, 18, 60, 0.9),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        fieldBody(context),
        const SizedBox(
          height: 10,
        ),
        popupMenuBody(context)
      ],
    );
  }

  Widget fieldBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(11, 13, 24, 0.9019607843137255),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: Provider.of<FolderProvider>(context).dialogController,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: contentMessage,
          )),
    );
  }

  Widget popupMenuBody(BuildContext context) {
    return Row(
      children: [
        myText("chose folder type", color: Colors.black, size: 18),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(10, 18, 60, 0.9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: PopupMenuButton<FolderType>(
            elevation: 20,
            padding: const EdgeInsets.all(8.0),
            onSelected: (folderType) {
              Provider.of<FolderProvider>(context, listen: false)
                  .changeFolderType(folderType);
            },
            initialValue: Provider.of<FolderProvider>(context).folderType,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FolderType>>[
              const PopupMenuItem<FolderType>(
                value: FolderType.image,
                child: Text('image'),
              ),
              const PopupMenuItem<FolderType>(
                value: FolderType.audio,
                child: Text('audio'),
              ),
              const PopupMenuItem<FolderType>(
                value: FolderType.video,
                child: Text('video'),
              ),
              const PopupMenuItem<FolderType>(
                value: FolderType.exel,
                child: Text('exel'),
              ),
              const PopupMenuItem<FolderType>(
                value: FolderType.txt,
                child: Text("text"),
              ),
            ],
            child: Row(
              children: [
                myText(convertFolderTypeToString(
                    Provider.of<FolderProvider>(context).folderType)),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onSave(BuildContext context) async {
    await Provider.of<FolderProvider>(context, listen: false).crateFolder(
        Provider.of<FolderProvider>(context, listen: false)
            .dialogController
            .text,
        convertFolderTypeToString(
            Provider.of<FolderProvider>(context, listen: false).folderType));
  }
}
