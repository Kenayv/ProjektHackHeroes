// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, unused_element, avoid_print, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../user.dart';
import 'package:path_provider/path_provider.dart';

//  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

//A logical representation of the ToDoPage task. contains the tasks string and information whether the task is completed. Saved tasks are stored in tasks.json file.
class TodoTask {
  String task;
  bool isCompleted;

  TodoTask({
    required this.task,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'isCompleted': isCompleted,
    };
  }

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      task: json['task'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

//  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();

  final List<TodoTask> tasks = [];
  List<TodoTask> getTasks() {
    return tasks;
  }
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController taskController = TextEditingController();
  List<TodoTask> tasks = TodoPage().getTasks();
  void _saveTasks() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/tasks.json';
    File file = File(filePath);
    List<Map<String, dynamic>> jsonTasks = tasks.map((todo) => todo.toJson()).toList();
    file.writeAsStringSync(jsonEncode(jsonTasks));
  }

  //Reads tasks saved in tasks.json file and pushes them into tasks[] array
  void _loadTasks() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/tasks.json';
      File file = File(filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        List<dynamic> decodedTasks = jsonDecode(content);
        List<TodoTask> loadedTasks = decodedTasks.map((task) => TodoTask.fromJson(task)).toList();
        setState(() {
          tasks = loadedTasks;
        });
      }
    } catch (e) {
      //FIXME: Tu powinien się wyświetlać na stronie TODO komunikat że się nie udało.
      print("Error loading tasks: $e");
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      if (!tasks[index].isCompleted) {
        currentUser.incrFinishedTask();
      } else {
        currentUser.decrFinishedTask();
      }
      tasks[index].isCompleted = !tasks[index].isCompleted;
      _saveTasks();
    });
  }

  void _addTask(String task) {
    setState(() {
      tasks.insert(0, TodoTask(task: task));
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

  //Opens a new pop-up window allowing user to change a task content. Invoked on a task's long press.
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

  //Opens a new pop-up window allowing user to add a task. Function invoked on (+) button press.
  Future<dynamic> _addTaskDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dodaj zadanie'),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: 'Nowe zadanie'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Dodaj'),
              onPressed: () {
                _addTask(taskController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Returns an object which is visual representation of the task. This function is used to draw a task item on the screen.
  Widget _buildTaskItem(TodoTask todo) {
    return ListTile(
      title: Dismissible(
        key: Key(todo.hashCode.toString()),
        child: ListTile(
          title: Text(
            todo.task,
            style: TextStyle(
                decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                color: usertheme.TextColor),
          ),
          onLongPress: () {
            _editTaskDialog(context, tasks.indexOf(todo));
          },
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            if (!todo.isCompleted) currentUser.incrFailedTask();
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

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<TodoTask> incompleteTasks = tasks.where((task) => !task.isCompleted).toList();
    List<TodoTask> completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      backgroundColor: usertheme.Primarybgcolor, // Set the background color here
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: usertheme.TextColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: incompleteTasks.length,
              itemBuilder: (context, index) {
                TodoTask todo = incompleteTasks[index];
                return _buildTaskItem(todo);
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: usertheme.TextColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                TodoTask todo = completedTasks[index];
                return _buildTaskItem(todo);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: usertheme.Page1,
      ),
    );
  }
}
