import 'package:flutter/material.dart';
import 'package:note/view/home/editing.dart';

import 'home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:  Color.fromRGBO(
              10, 18, 60, 0.9),
        ),

        appBarTheme: const AppBarTheme(
          color:   Color.fromRGBO(
              10, 18, 60, 0.9),
        ),
        primaryColor: const Color.fromRGBO(
            10, 18, 60, 0.9),
      ),
      routes: {

        EditingPage.routeName:(context)=>EditingPage(),

      },
      home: Home(),
    );
  }
}
