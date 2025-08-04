import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: Calculator()),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentInput = "";
  double _result = 0.0;
  String _operator = "";

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _result = 0.0;
        _operator = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x") {
        if (_currentInput.isNotEmpty) {
          _result = double.parse(_currentInput);
          _operator = buttonText;
          _currentInput = "";
          _output = _result.toString();
        }
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
          double secondOperand = double.parse(_currentInput);
          if (_operator == "+") {
            _result += secondOperand;
          } else if (_operator == "-") {
            _result -= secondOperand;
          } else if (_operator == "x") {
            _result *= secondOperand;
          }
          _output = _result.toString();
          _operator = "";
          _currentInput = "";
        }
      } else if (buttonText == "Q3") {
        // Placeholder for a custom function (e.g., square root)
        _output = "Q3 pressed";
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Text(
            _output,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Grid Buttons (5x5)
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            children: [
              _buildButton("C", Colors.orange),
              _buildButton("Q3", Colors.grey),
              _buildButton("+", Colors.grey),
              _buildButton("x", Colors.grey),
              _buildButton("7", Colors.white),
              _buildButton("8", Colors.white),
              _buildButton("9", Colors.white),
              _buildButton("-", Colors.grey),
              _buildButton("4", Colors.white),
              _buildButton("5", Colors.white),
              _buildButton("6", Colors.white),
              _buildButton("+", Colors.grey),
              _buildButton("1", Colors.white),
              _buildButton("2", Colors.white),
              _buildButton("3", Colors.white),
              _buildButton("=", Colors.orange),
              _buildButton("", Colors.black), // Empty cell
              _buildButton("0", Colors.white),
              _buildButton("00", Colors.white),
              _buildButton("", Colors.black), // Empty cell
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () => _onButtonPressed(text),
        child: Text(
          text,
          style: TextStyle(
            color: color == Colors.white ? Colors.black : Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
