import 'package:flutter/material.dart';
import 'package:quiz_maniac/screens/quiz_category_screen.dart';
import 'package:quiz_maniac/screens/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Fanatic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Ubuntu Sans',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Ubuntu Sans',
      ),
      themeMode: ThemeMode.system,
      home: const QuizCategory(),
    );
  }
}
