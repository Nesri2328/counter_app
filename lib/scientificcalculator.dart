import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(const ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      theme: ThemeData(
        useMaterial3: true, // Enable Material 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ), // Different seed color
        textTheme: GoogleFonts.exo2TextTheme(
          // Exo 2 is a modern font
          Theme.of(context).textTheme,
        ),
      ),
      home: const ScientificCalculatorScreen(),
    );
  }
}

class ScientificCalculatorScreen extends StatefulWidget {
  const ScientificCalculatorScreen({super.key});

  @override
  ScientificCalculatorScreenState createState() =>
      ScientificCalculatorScreenState();
}

class ScientificCalculatorScreenState
    extends State<ScientificCalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 28.0;
  double resultFontSize = 48.0;
  bool isScientific = false;

  // ignore: strict_top_level_inference
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 28.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 28.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 28.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('π', pi.toString());
        expression = expression.replaceAll('e', e.toString());
        expression = expression.replaceAll(
          '√',
          'sqrt',
        ); // Make sure parser knows sqrt

        try {
          // ignore: deprecated_member_use
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          // ignore: deprecated_member_use
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error"; // Better error handling
          // ignore: avoid_print
          print(e); // Log the error for debugging
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 28.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation =
              "$equation$buttonText"; // More concise string concatenation
        }
      }
    });
  }

  Widget buildButton(String buttonText) {
    Color buttonColor = Colors.grey[200]!;
    Color textColor = Colors.black87;

    if (buttonText == "C" || buttonText == "⌫") {
      buttonColor = Colors.redAccent;
      textColor = Colors.white;
    } else if (buttonText == "=") {
      buttonColor = Theme.of(context).colorScheme.primary;
      textColor = Colors.white;
    } else if (["+", "-", "×", "÷"].contains(buttonText)) {
      buttonColor = Colors.blueGrey[100]!;
      textColor = Theme.of(context).colorScheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          textStyle: const TextStyle(
            fontSize: 24,
          ), // Smaller font for more buttons
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ), // Softer corners
          elevation: 1, // Even subtler shadow
        ),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      equation,
                      style: TextStyle(
                        fontSize: equationFontSize,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: resultFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Toggle Scientific Mode Button
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isScientific = !isScientific;
                });
              },
              child: Text(isScientific ? "Basic Mode" : "Scientific Mode"),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildButton("C"),
                buildButton("⌫"),
                buildButton("%"),
                buildButton("÷"),

                if (isScientific) ...[
                  buildButton("sin"),
                  buildButton("cos"),
                  buildButton("tan"),
                  buildButton("π"),

                  buildButton("log"),
                  buildButton("ln"),
                  buildButton("√"),
                  buildButton("^"),

                  buildButton("("),
                  buildButton(")"),
                  buildButton("e"),
                  buildButton("!"), // Implement factorial
                ],

                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("×"),

                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("-"),

                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("+"),

                buildButton("00"),
                buildButton("0"),
                buildButton("."),
                buildButton("="),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
