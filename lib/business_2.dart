// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF87CEEB), // Light Blue background
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 87, 118),
          title: const Text(
            'Business Card',
            style: TextStyle(
              color: Colors.black87, // Adjust color as needed
            ),
          ),
          centerTitle: true,
          elevation: 0, // Remove shadow
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align to top
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Add some space after the title
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/128/737/737967.png',
                  ), // Replace with the actual image URL
                  backgroundColor: Colors.black, // Photo background
                ),
                const SizedBox(height: 40), // Increased spacing

                CardItem(title: 'Call Me Maybe:', icon: Icons.phone),
                const SizedBox(height: 10),
                CardItem(title: 'WhatsApp:', icon: Icons.chat),
                const SizedBox(height: 10),
                CardItem(title: 'E-mail:', icon: Icons.email),
                const SizedBox(height: 10),
                CardItem(title: 'Instagram:', icon: Icons.center_focus_weak),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({Key? key, required this.title, required this.icon})
    : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.white,
            Color.fromARGB(255, 31, 111, 158),
          ], // Gradient effect
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25), // Rounded edges
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between text and icon
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, // Increase font size for readability
                fontWeight: FontWeight.w500, // Add a bit of boldness
                color: Colors.black87, // Consider dark text for contrast
              ),
            ),
            Icon(icon, color: Colors.black87), // Icon on the right
          ],
        ),
      ),
    );
  }
}
