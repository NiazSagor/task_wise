import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_wise/core/constants/utils.dart';
import 'package:task_wise/features/home/presentation/widgets/date_selector.dart';
import 'package:task_wise/features/home/presentation/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))],
      ),
      body: Column(
        children: [
          // date selector
          DateSelector(),
          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Color.fromRGBO(246, 222, 194, 1),
                  title: "Task 1",
                  description: "Description 1",
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: strengthenColor(
                    Color.fromRGBO(246, 222, 194, 1),
                    0.69,
                  ),
                  shape: BoxShape.circle,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("10:00AM", style: TextStyle(fontSize: 17)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
