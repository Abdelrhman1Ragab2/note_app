import 'package:flutter/material.dart';




Widget myText(String text,{double size=14,Color? color=Colors.white}){
  return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
        overflow: TextOverflow.ellipsis
      )
  );
}