import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, required this.actionAddTask});

  final Function(Task) actionAddTask;

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Descreva sua atividade'),
        ),
        ElevatedButton(
          onPressed: () async {
            String description = taskController.text;
            String date =
                DateFormat('kk:mm – dd-MM-yyyy').format(DateTime.now());
            final task = Task(description: description, date: date);
            widget.actionAddTask(task);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
