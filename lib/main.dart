import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:section2/common/component/custom_text_form_field.dart';
import 'package:section2/common/view/splash_screen.dart';
import 'package:section2/user/view/login_screen.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
