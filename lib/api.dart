import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  final String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Map<String, dynamic>>> _fetchTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = await jsonDecode(response.body);
      return data.map((d) => d as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load Todos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error r: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>>? todos = snapshot.data;
            if (todos!.isEmpty) {
              return const Center(child: Text("No data found"));
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Text(todo['id'].toString()),
                  title: Text(todo['title']),
                  subtitle: Text(todo['body']),
                );
              },
            );
          }
          return Center(child: Text("Unknown error"));
        },
      ),
    );
  }
}
