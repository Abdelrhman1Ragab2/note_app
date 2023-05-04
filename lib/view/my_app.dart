import 'package:flutter/material.dart';
import 'package:note/view/home/notes_part/editing.dart';

import 'dashbord.dart';
import 'home/documentation_part/document_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:  Color.fromRGBO(
              10, 18, 60, 0.9),
        ),

        appBarTheme: const AppBarTheme(
          color:   Color.fromRGBO(
              10, 18, 60, 0.9),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.white)
        ),
        primaryColor: const Color.fromRGBO(
            47, 47, 59, 1.0),
        secondaryHeaderColor: const Color.fromRGBO(76, 146, 176, 1.0),
      ),

      routes: {
        EditingPage.routeName:(context)=>EditingPage(),
        DocumentationScreen.routeName:(context)=>const DocumentationScreen(),

      },

      home: DashBord(),
    );
  }
}
