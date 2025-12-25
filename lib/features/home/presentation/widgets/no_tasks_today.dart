import 'package:flutter/material.dart';

class NoTasksToday extends StatelessWidget {
  const NoTasksToday({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.task, size: 70, color: Colors.deepOrangeAccent.shade100),
        Text(
          "You do not have any tasks yet!",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          textAlign: TextAlign.center,
        ),
        Text(
          "Add new tasks to make your days\nproductive.",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
