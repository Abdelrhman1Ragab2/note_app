import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note/core/const/app_constant.dart';
import 'package:provider/provider.dart';

import '../../../controller/note_provider.dart';
import '../../../core/widget/dialog/document_dialog.dart';
import '../../../core/widget/dialog/noteDialog.dart';
import '../../../core/widget/my_text.dart';
import '../../../model/note.dart';

class EditingPage extends StatelessWidget {
  EditingPage({Key? key}) : super(key: key);
  static const routeName = "EditingPage";

  TextEditingController titleController = TextEditingController();
  final yourScrollController = ScrollController();
  TextEditingController contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final routArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Note? note = routArg["note"];
    final bool isNewNote=note==null;
    if(!isNewNote){
      titleController.text=note.title;
      contentController.text=note.content;
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appBarBody(context,isNewNote,note),
      floatingActionButton:floatingButtonBody(context,isNewNote,note==null?"unUseKey":note.id),
      body: buildBody(context,note,isNewNote),
    );
  }
  PreferredSizeWidget appBarBody(BuildContext context,bool isNewNote,Note? note){
    return AppBar(
        title: appBarTitleBody(isNewNote?"New note":note!.id) ,
        centerTitle: true,
        leading: leadingBody(context),
        actions: actionBody(context,isNewNote,note==null?"unUseKey":note.id)
    );
  }

  Widget appBarTitleBody(String title){
    return Text(title);
  }

  Widget leadingBody(BuildContext context){
    return IconButton(onPressed: (){
      Provider.of<NoteProvider>(context,listen: false).resetDefaultBoolean();
      Navigator.pop(context);
    },icon:const Icon(Icons.arrow_back),);
  }

  List<Widget> actionBody(BuildContext context,bool isNewNote,String? key){
    return[
      Visibility(
        visible: !isNewNote,
        child: IconButton(onPressed: ()async{
          await Provider.of<NoteProvider>(context,listen: false).deleteNoteByKey(key!);
          Navigator.pop(context);
        }, icon: const Icon(Icons.delete)),
      ),
      IconButton(onPressed: ()async{
        final String? imageUrl= Platform.isAndroid? await getImagePathForAndroid()
            :await getImageForWindows();

        if(imageUrl!=null)
          {
            Provider.of<NoteProvider>(context,listen: false).changeDefaultImage(imageUrl);
          }
      }, icon: const Icon(Icons.camera)),

    ];
  }

  Widget floatingButtonBody(BuildContext context ,bool isNewNote,String key ){
    return FloatingActionButton(

      onPressed: () async {
        await openDialog(context,isNewNote,key);
        Navigator.pop(context);
      },
      child:  Icon(isNewNote?Icons.save:Icons.edit),
    );
  }

  Widget buildBody(BuildContext context,Note? note,bool isNewNote) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(18.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Scrollbar(

            controller: yourScrollController,
            isAlwaysShown: true,
            thickness: 8,
              child: SingleChildScrollView(
                controller: yourScrollController,
                child: Column(
                    children: [
                      infoBody(note?.lastUpdate,isNewNote),
                      const SizedBox(
                        height: 10,
                      ),
                      myListTitle(context,note)
                    ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget infoBody(String? dateTime,bool isNewNote) {

    return Row(
      children: [
        myText(DateFormat.yMMMEd().format(isNewNote?DateTime.now():DateTime.parse(dateTime!))),
        const SizedBox(width: 20,),
        myText(DateFormat.jm().format(isNewNote?DateTime.now():DateTime.parse(dateTime!))),
      ],
    );
  }

  Widget myListTitle(BuildContext context,Note?note) {
    return Column(
      children: [
        titleBody(context,note),
        const SizedBox(height: 10,),
        contentBody(context)
      ],

    );
  }

  Widget titleBody(BuildContext context,Note?note){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

          Expanded(
            flex: 8,
            child: TextFormField(
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
          ),
        const SizedBox(width: 20,),
        Expanded(flex: 1,
            child: imageBody(context,note))


      ],
    );
  }

  Widget imageBody(BuildContext context,Note?note){
    return (note==null  || note.isDefaultImage) &&(Provider.of<NoteProvider>(context).isDefaultImage) ? const CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(AppConstant.defaultImageURl),

    ):
    CircleAvatar(
        radius: 50,
        backgroundImage:FileImage(
            File(Provider.of<NoteProvider>(context).isDefaultImage?note!.coverImageUrl:
                Provider.of<NoteProvider>(context).newImageUrl) )

    );
  }

  Widget contentBody(BuildContext context){
    return
     TextFormField(

          style: const TextStyle(color: Colors.white,fontSize: 20),
          minLines: 10,
          maxLines: 250,
          controller: contentController,
          decoration: InputDecoration(
            fillColor: Colors.black54,
            filled: true,

            border: const OutlineInputBorder( borderSide: BorderSide(color:  Color.fromARGB(
                201, 12, 23, 23),
            )),
            hintStyle: const TextStyle(color: Colors.grey),
            hintText:
            contentController.text.isEmpty ? "please write beautiful something from your amazing thinking"
                : contentController.text,

          )
    );
  }

 Future< String?>getImagePathForAndroid()async {
    final XFile? imageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
       return imageFile.path;

    }
    else {
      return null;
    }
  }

  Future<String?> getImageForWindows()async{
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(dialogTitle: "choseImage",
        type: FileType.image,


        allowedExtensions: ['jpg', 'png', ],

      );
      if (result != null) {
        PlatformFile file = result.files.first;

        return file.path;
      }
      else {
        return null;
      }

    } catch (e) {
      return null;
    }

  }

  Future<void>openDialog(BuildContext context,bool isNewNote,String key)async{
    await showDialog(context: context, builder: (context){
      return NoteDialog(
        title: titleController.text,
        content: contentController.text,
        isNewNote: isNewNote,
        noteId: key,

      );
    });

}



}
