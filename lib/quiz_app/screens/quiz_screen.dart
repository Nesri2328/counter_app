// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int get _currentQuestionIndex => 0;
  int? _selectedOptionIndex; // Store the index of the selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question
            Card(
              color: AppTheme.cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Sample Question Text?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Options
            ...List.generate(
              4, // Number of answer options
              (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedOptionIndex == index
                        ? AppTheme.optionSelectedColor
                        : AppTheme.cardBackgroundColor,
                    foregroundColor: AppTheme.lightTextColor,
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedOptionIndex = index; // Select current option.
                    });
                  },
                  child: Text('Answer Option $index'),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Explanation and Navigation
            ElevatedButton(
              onPressed: () {
                // After quiz ends go to next screen.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultScreen()),
                );
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
