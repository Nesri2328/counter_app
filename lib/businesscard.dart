import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(
          255,
          63,
          2,
          99,
        ), // Replace with the exact teal color
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'download.jpg',
                  ), // Replace with the actual image URL
                ),
                SizedBox(height: 20),
                Text(''),
                Text(
                  'Umitiya Esmael',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Hand',
                    // fontFamily: 'YourScriptFont', // Uncomment and set if you have a custom font
                  ),
                ),
                Text(
                  'FLUTTER JUNIOR DEVELOPER',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Monospace',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double
                      .infinity, // Make it stretch to fill the available width
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 97, 66, 222),
                      ),
                      SizedBox(width: 10),
                      Text('+251 923 28 67 07'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 71, 24, 172),
                      ),
                      SizedBox(width: 10),
                      Text('nesraesmael4@gmail.com'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
