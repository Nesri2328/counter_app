import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class FirstApp extends StatefulWidget {
  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  // ignore: prefer_final_fields
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Counter App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Center(child: Text(_counter.toString())),
    );
  }
}
