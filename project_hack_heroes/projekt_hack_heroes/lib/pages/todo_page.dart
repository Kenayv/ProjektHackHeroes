import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: TodoPage(),
  ));
}

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
    List<Map<String, dynamic>> jsonTasks =
        tasks.map((todo) => todo.toJson()).toList();
    file.writeAsStringSync(jsonEncode(jsonTasks));
  }

  void _loadTasks() {
    try {
      File file = File(_filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        List<dynamic> decodedTasks = jsonDecode(content);
        List<Todo> loadedTasks =
            decodedTasks.map((task) => Todo.fromJson(task)).toList();
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

  @override
  Widget build(BuildContext context) {
    List<Todo> incompleteTasks =
        tasks.where((task) => !task.isCompleted).toList();
    List<Todo> completedTasks =
        tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: incompleteTasks.length,
              itemBuilder: (context, index) {
                Todo todo = incompleteTasks[index];
                return Dismissible(
                  key: Key(todo.hashCode.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      tasks.remove(todo);
                    });
                    _saveTasks();
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                  child: ListTile(
                    title: Text(
                      todo.task,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    onTap: () {
                      _toggleTaskCompletion(tasks.indexOf(todo));
                    },
                    onLongPress: () {
                      _editTaskDialog(context, tasks.indexOf(todo));
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Completed Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                Todo todo = completedTasks[index];
                return ListTile(
                  title: Text(
                    todo.task,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    _toggleTaskCompletion(tasks.indexOf(todo));
                  },
                  onLongPress: () {
                    _editTaskDialog(context, tasks.indexOf(todo));
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTaskDialog(BuildContext context) async {
    TextEditingController taskController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: taskController,
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
              child: Text('Add'),
              onPressed: () {
                String task = taskController.text;
                if (task.isNotEmpty) {
                  _addTask(task);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editTaskDialog(BuildContext context, int index) async {
    TextEditingController editTaskController =
        TextEditingController(text: tasks[index].task);
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
}
