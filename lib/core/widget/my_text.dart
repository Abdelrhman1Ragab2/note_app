import 'package:flutter/material.dart';

Widget myText(String text,{double size=14,}){
  return Text(text,
      style: TextStyle(
          color: Colors.white,
          fontSize: size
      ));
}