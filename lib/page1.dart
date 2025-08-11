import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('page1'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/page3');
              // Navigat
            },
            child: Text("Go to page3"),
          ),
        ],
      ),
    );
  }
}
