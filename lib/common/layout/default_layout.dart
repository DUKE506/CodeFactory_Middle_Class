import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgrounColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  const DefaultLayout({
    super.key,
    required this.child,
    this.backgrounColor = Colors.white,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      backgroundColor: backgrounColor,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  //앱바
  AppBar? renderAppBar() {
    if (title != null) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      );
    } else {
      return null;
    }
  }
}
