// lib/providers/quiz_provider.dart
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider with ChangeNotifier {
  List<Question> get _questions =>
      questions; // Import the questions from question.dart

  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _quizCompleted = false;
  bool _answerWasSelected = false; // Track if any answer was selected.
  int? _selectedAnswerIndex; // Track selected answer index
  List<bool?> _answerResults =
      []; // null = not answered, true = correct, false = incorrect

  // Load saved progress
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _currentQuestionIndex = prefs.getInt('currentQuestionIndex') ?? 0;
    _correctAnswers = prefs.getInt('correctAnswers') ?? 0;
    _quizCompleted = prefs.getBool('quizCompleted') ?? false;
    _answerResults = List.generate(
      _questions.length,
      (i) => null,
    ); // Initialize results

    notifyListeners();
  }

  // Save progress
  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentQuestionIndex', _currentQuestionIndex);
    await prefs.setInt('correctAnswers', _correctAnswers);
    await prefs.setBool('quizCompleted', _quizCompleted);
  }

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get correctAnswers => _correctAnswers;
  bool get quizCompleted => _quizCompleted;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get answerWasSelected => _answerWasSelected;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  List<bool?> get answerResults => _answerResults;

  // Actions
  void selectAnswer(int index) {
    _selectedAnswerIndex = index;
    _answerWasSelected = true;
    notifyListeners();
  }

  void submitAnswer() {
    if (!_answerWasSelected) return; // Prevent submitting without selecting

    bool isCorrect =
        _selectedAnswerIndex ==
        _questions[_currentQuestionIndex].correctAnswerIndex;
    _answerResults[_currentQuestionIndex] = isCorrect;

    if (isCorrect) {
      _correctAnswers++;
    }

    notifyListeners();
    saveProgress();
  }

  void nextQuestion() {
    if (!_answerWasSelected) return; // Prevent advancing without selecting

    _answerWasSelected = false;
    _selectedAnswerIndex = null;

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _quizCompleted = true;
    }
    notifyListeners();
    saveProgress();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _quizCompleted = false;
    _answerWasSelected = false;
    _selectedAnswerIndex = null;
    _answerResults = List.generate(_questions.length, (i) => null);

    notifyListeners();
    saveProgress();
  }

  double get completionRate {
    return (_currentQuestionIndex + 1) / _questions.length;
  }
}
