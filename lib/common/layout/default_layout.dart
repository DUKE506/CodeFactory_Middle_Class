import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgrounColor;
  final Widget child;
  const DefaultLayout(
      {super.key, required this.child, this.backgrounColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      body: child,
    );
  }
}
