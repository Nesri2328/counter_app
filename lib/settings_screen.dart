import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Options Here')),
    );
  }
}
