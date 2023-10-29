import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Todo {
  String task;
  bool isCompleted;

  Todo({
    required this.task,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      task: json['task'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> tasks = [];
  TextEditingController taskController = TextEditingController();
  final String _filePath = "tasks.json";

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _addTask(String task) {
    setState(() {
      tasks.insert(0, Todo(task: task));
      _saveTasks();
    });
  }

  void _saveTasks() {
    File file = File(_filePath);
    List<Map<String, dynamic>> jsonTasks = tasks.map((todo) => todo.toJson()).toList();
    file.writeAsStringSync(jsonEncode(jsonTasks));
  }

  void _loadTasks() {
    try {
      File file = File(_filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        List<dynamic> decodedTasks = jsonDecode(content);
        List<Todo> loadedTasks = decodedTasks.map((task) => Todo.fromJson(task)).toList();
        setState(() {
          tasks = loadedTasks;
        });
      }
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      _saveTasks();
    });
  }

  void _editTask(int index, String newTask) {
    setState(() {
      tasks[index].task = newTask;
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  Future<void> _editTaskDialog(BuildContext context, int index) async {
    TextEditingController editTaskController = TextEditingController(text: tasks[index].task);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: editTaskController,
                  decoration: InputDecoration(labelText: 'Task'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _editTask(index, editTaskController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> incompleteTasks = tasks.where((task) => !task.isCompleted).toList();
    List<Todo> completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: incompleteTasks.length,
              itemBuilder: (context, index) {
                Todo todo = incompleteTasks[index];
                return _buildTaskItem(todo);
              },
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                Todo todo = completedTasks[index];
                return _buildTaskItem(todo);
              },
            ),
            // Dodaj więcej sekcji, jeśli są potrzebne.
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(Todo todo) {
    return ListTile(
      title: Dismissible(
        key: Key(todo.hashCode.toString()),
        child: ListTile(
          title: Text(
            todo.task,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          onLongPress: () {
            _editTaskDialog(context, tasks.indexOf(todo));
          },
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            _deleteTask(tasks.indexOf(todo));
          } else if (direction == DismissDirection.endToStart) {
            _toggleTaskCompletion(tasks.indexOf(todo));
          }
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
