import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: Center(child: Text('List of Tasks Here')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Task Screen
          Navigator.pushNamed(context, '/addTask');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
