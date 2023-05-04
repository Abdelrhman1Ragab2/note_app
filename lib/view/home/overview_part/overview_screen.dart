import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key}) : super(key: key);
  static const routeName="OverView";

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text(routeName),
    );
  }
}
