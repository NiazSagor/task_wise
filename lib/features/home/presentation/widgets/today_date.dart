import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayDate extends StatelessWidget {
  const TodayDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.yMMMMd('en_US').format(DateTime.now()),
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
        ),
        Text(
          "Today",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
