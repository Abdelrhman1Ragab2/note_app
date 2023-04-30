import 'package:flutter/material.dart';

class DaySummary extends StatelessWidget {
  const DaySummary({Key? key}) : super(key: key);
  static const routeName="DaySummary";

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text(routeName),
    );
  }
}
