import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Center(child: Text('Add Task Form Here')),
    );
  }
}
