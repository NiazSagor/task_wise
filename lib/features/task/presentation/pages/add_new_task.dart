import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: "Description"),
                maxLines: 4,
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
                onPressed: () {},
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
