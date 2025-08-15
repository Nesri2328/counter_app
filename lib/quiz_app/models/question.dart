// lib/models/question.dart
class Question {
  final String text;
  final List<String> options;
  final int
  correctAnswerIndex; // Index of the correct option in the options list
  final String explanation; // Explanation shown after answering

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

// Example Usage
final List<Question> questions = [
  Question(
    text: 'What is Flutter?',
    options: [
      'A programming language',
      'A UI framework',
      'A database',
      'An operating system',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Flutter is a UI framework by Google for building natively compiled applications.',
  ),
  Question(
    text: 'What does the acronym UI stand for?',
    options: [
      'Ultimate Interface',
      'User Integration',
      'User Interface',
      'Universal Instruction',
    ],
    correctAnswerIndex: 2,
    explanation: 'UI stands for User Interface.',
  ),
  // Add more questions here
];
