import 'package:flutter/material.dart';
import 'package:note/controller/bottom_provider.dart';
import 'package:note/controller/note_provider.dart';
import 'package:note/model/note.dart';
import 'package:note/view/home/day_summary.dart';
import 'package:note/view/home/plans.dart';
import 'package:provider/provider.dart';

import 'editing.dart';
import 'notes.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex=Provider.of<BottomProvider>(context).currentIndex;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.summarize_outlined), label: "DS"),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Note"),
          BottomNavigationBarItem(icon: Icon(Icons.next_plan_outlined), label: "plan"),

        ],
        onTap: (index) {
          Provider.of<BottomProvider>(context,listen: false).changeIndex(index);
        },
        currentIndex: currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            Navigator.pushNamed(context, EditingPage.routeName,arguments: {"note":null});
          },
          child: const Icon(Icons.add,)
      ),

      body: homeScreens[currentIndex],

    );
  }
  List<Widget> homeScreens=const [DaySummary(),Notes(),Plans()];
}
