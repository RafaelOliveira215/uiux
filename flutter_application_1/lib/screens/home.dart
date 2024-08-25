import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/task_form.dart';
import 'package:flutter_application_1/models/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> taskList = [];
  final List<TextEditingController> _controllers = [];

  void addTask(Task task) {
    setState(() {
      taskList.add(task);
      _controllers.add(TextEditingController(text: task.description));
    });
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
      _controllers.removeAt(index);
    });
  }

  void editTask(String value, int index) {
    setState(() {
      taskList[index].description = value;
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      taskList[index].isCompleted = !taskList[index].isCompleted;
    });
  }

  int get completedTasksCount {
    return taskList.where((task) => task.isCompleted).length;
  }

  int get totalTasksCount {
    return taskList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Tasks: $totalTasksCount | Completed: $completedTasksCount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TaskForm(
            actionAddTask: addTask,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                TextEditingController controller = _controllers[index];
                Task task = taskList[index];

                return ListTile(
                  title: TextFormField(
                    controller: controller,
                    style: TextStyle(
                      fontSize: 18,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      editTask(value, index);
                    },
                  ),
                  subtitle: Text(
                    task.date,
                  ),
                  leading: Icon(
                    task.isCompleted ? Icons.check_circle : Icons.circle,
                    size: 24,
                    color: task.isCompleted ? Colors.green : null,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          task.isCompleted ? Icons.undo : Icons.done,
                          color: task.isCompleted ? Colors.blue : null,
                        ),
                        onPressed: () {
                          toggleTaskCompletion(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
