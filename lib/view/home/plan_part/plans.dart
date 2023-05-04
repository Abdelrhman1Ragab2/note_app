import 'package:flutter/material.dart';

class Plans extends StatelessWidget {
  const Plans({Key? key}) : super(key: key);
  static const routeName="Plans";

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text(routeName),
    );
  }
}
