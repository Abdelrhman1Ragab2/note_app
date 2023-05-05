import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/controller/bottom_provider.dart';
import 'package:note/core/widget/floation_button_functions.dart';
import 'package:note/controller/menu_provider.dart';
import 'package:provider/provider.dart';

import '../controller/folder_provider.dart';
import 'menu/menu_ui.dart';

class DashBord extends StatelessWidget {
  const DashBord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Platform.isAndroid?Provider.of<BottomProvider>(context).currentIndex:Provider.of<MenuProvider>(context).menusSelectedIndex;
    return Scaffold(
      appBar: Platform.isAndroid?AppBar(
        actions: [IconButton(onPressed: (){
          Provider.of<FolderProvider>(context,listen: false).clearBox();
        }, icon: const Icon(Icons.clear))],
      ):null,

      bottomNavigationBar: Platform.isAndroid
          ? BottomNavigationBar(
              items: bottomNavigationBarItemBody(context),
              onTap: (index) {
                Provider.of<BottomProvider>(context, listen: false)
                    .changeIndex(index);
              },
              currentIndex: currentIndex,
            )
          : null,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FloatingFunction().doOperation(currentIndex, context);
          },
          child: const Icon(
            Icons.add,
          )),

      body: buildBody(context,currentIndex),
    );
  }

  List <BottomNavigationBarItem> bottomNavigationBarItemBody(BuildContext context){
    List <BottomNavigationBarItem> items=[];
    Provider.of<MenuProvider>(context).menus.forEach((element) {
      items.add(BottomNavigationBarItem(icon:Icon(element.icon),label: element.title ));
    });
    return items;
  }

  Widget buildBody(BuildContext context,int currentIndex) {
    return Row(
      children: [
        Platform.isWindows
            ? Expanded(flex: 1, child: menuBody())
            : const SizedBox(),
        Expanded(flex: 5, child: homeBody(context,currentIndex)),
      ],
    );
  }

  Widget menuBody() {
    return const MenuUI();
  }

  Widget homeBody(BuildContext context,int index) {
    return SizedBox(
      height: double.maxFinite,
        child: Provider.of<BottomProvider>(context).homeScreens[index]);
  }


}
