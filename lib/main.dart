import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/quiz_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnificent Quiz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Enforce the dark theme
      home: QuizHomeScreen(), // Start at the home screen
    );
  }
}
