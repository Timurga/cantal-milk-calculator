import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор Cantal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        hintColor: Color(0x80f9f9f9),
        elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Color(0xfff69906),
          )
        ),
        primaryColor: Color(0xff0000000),
      ),
      home: HomePage(),
    );
  }
}