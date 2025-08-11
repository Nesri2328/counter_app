import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String deadline;

  const TaskDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.deadline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title', style: Theme.of(context).textTheme.labelLarge),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Text('Description', style: Theme.of(context).textTheme.labelLarge),
            Text(description),
            const SizedBox(height: 24),
            Text('Deadline', style: Theme.of(context).textTheme.labelLarge),
            Text(deadline),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Start task logic
                },
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
