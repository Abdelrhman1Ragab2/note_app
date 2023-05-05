import 'dart:io';

import 'package:flutter/material.dart';

import 'my_text.dart';

class ImageDialog extends StatelessWidget {
  final String imagePath;
  

  const ImageDialog(
      {Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 100,top: 100,right: 250,left: 250),
      child: AlertDialog(
          elevation: 20,
          content: contentBody(context),
         
      ),
    );
  }


  Widget contentBody(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageBody(),
          const SizedBox(height: 20,),
          pathBody()
        ],
      );
  }

  Widget pathBody(){
    return Container(
        color :Colors.black54,
        child: myText(imagePath));
  }
  Widget imageBody(){
   return Image.file(
      File(imagePath),
      width: 350,
      height: 350,
      fit: BoxFit.contain,
    );
  }





}
