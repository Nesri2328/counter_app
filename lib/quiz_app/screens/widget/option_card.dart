// lib/widgets/option_card.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const OptionCard({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (isSelected) {
      if (isCorrect == true) {
        backgroundColor = AppTheme.correctAnswerColor;
        textColor = AppTheme.lightTextColor;
      } else if (isCorrect == false) {
        backgroundColor = AppTheme.incorrectAnswerColor;
        textColor = AppTheme.lightTextColor;
      } else {
        backgroundColor = AppTheme.accentColor;
        textColor = AppTheme.lightTextColor;
      }
    } else {
      backgroundColor = AppTheme.cardBackgroundColor;
      textColor = AppTheme.darkTextColor;
    }

    return Card(
      elevation: 2,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            option,
            style: TextStyle(fontSize: 18, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
