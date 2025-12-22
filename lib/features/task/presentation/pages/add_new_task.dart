import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_wise/core/common/widgets/loader.dart';
import 'package:task_wise/core/utils/show_snackbar.dart';
import 'package:task_wise/features/home/presentation/pages/home_page.dart';
import 'package:task_wise/features/task/presentation/viewmodel/add_task_viewmodel.dart';

class AddNewTaskPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewTaskPage());

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Color selectedColor = Color.fromRGBO(246, 222, 194, 1);
  final formKey = GlobalKey<FormState>();

  void _addNewTask() async {
    if (formKey.currentState!.validate()) {
      final viewModel = Provider.of<AddTaskViewModel>(context, listen: false);
      await viewModel.addTask(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      if (context.mounted) {
        if (viewModel.isSuccess) {
          showSnackBar(context, "Task added successfully");
          Navigator.pushAndRemoveUntil(context, HomePage.route(), (_) => false);
        } else if (viewModel.errorMessage != null) {
          showSnackBar(context, viewModel.errorMessage!);
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
        actions: [
          GestureDetector(
            onTap: () async {
              final _selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 90)),
              );
              if (_selectedDate != null) {
                setState(() {
                  selectedDate = _selectedDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(DateFormat("MM-d-y").format(selectedDate)),
            ),
          ),
        ],
      ),
      body: Consumer<AddTaskViewModel>(
        builder: (context, viewModel, child) => _buildBody(viewModel),
      ),
    );
  }

  Widget _buildBody(AddTaskViewModel viewModel) {
    if (viewModel.isLoading) {
      return Loader();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: "Description"),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ColorPicker(
                pickersEnabled: {ColorPickerType.wheel: true},
                color: selectedColor,
                heading: Text("Select Color"),
                subheading: Text("Select a different shade"),
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addNewTask,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
