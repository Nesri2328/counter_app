// lib/screens/quiz_home_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart'; // Import quiz screen

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quizzes'), centerTitle: true),
      body: ListView.builder(
        itemCount: 5, // Replace with actual quiz data length
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.accentColor,
                child: Icon(
                  Icons.question_mark,
                  color: AppTheme.darkTextColor,
                ), // Representing quiz icon
              ),
              title: Text(
                'Quiz Title $index',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Category: Example Category\nDate: 11/12/2024'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ), // Navigate to the quiz
                );
              },
            ),
          );
        },
      ),
    );
  }
}
