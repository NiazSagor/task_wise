import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_wise/core/common/widgets/loader.dart';
import 'package:task_wise/core/constants/utils.dart';
import 'package:task_wise/core/utils/show_snackbar.dart';
import 'package:task_wise/features/home/presentation/viewmodel/task_viewmodel.dart';
import 'package:task_wise/features/home/presentation/widgets/date_selector.dart';
import 'package:task_wise/features/home/presentation/widgets/task_card.dart';
import 'package:task_wise/features/task/presentation/pages/add_new_task.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<InternetStatus> _subscription;
  DateTime selectedDate = DateTime.now();

  void _getTasks() {}

  void _syncTasks() {}

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        _syncTasks();
      }
    });
    _getTasks();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("My Tasks"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, AddNewTaskPage.route());
                },
                icon: Icon(CupertinoIcons.add),
              ),
            ],
          ),
          body: _buildBody(taskViewModel),
        );
      },
    );
  }

  Widget _buildBody(TaskViewModel viewModel) {
    if (viewModel.isLoading) {
      return Loader();
    }
    if (viewModel.tasks.isEmpty) {
      return const Center(child: Text("No tasks found."));
    }
    if (viewModel.errorMessage != null) {
      showSnackBar(context, viewModel.errorMessage!);
    }
    final tasks = viewModel.tasks
        .where(
          (e) =>
              DateFormat("d").format(e.dueAt) ==
                  DateFormat("d").format(selectedDate) &&
              selectedDate.month == e.dueAt.month &&
              selectedDate.year == e.dueAt.year,
        )
        .toList();
    return Column(
      children: [
        DateSelector(
          selectedDate: selectedDate,
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
        SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Row(
                children: [
                  Expanded(
                    child: TaskCard(
                      color: Colors.cyan,
                      title: task.title,
                      description: task.description,
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: strengthenColor(Colors.cyan, 0.69),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      DateFormat("hh:mm a").format(task.dueAt),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
