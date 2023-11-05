// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/user.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'todo_page.dart';
import 'dart:math';
import 'dart:io';

class HomePage extends StatelessWidget {
  List<TodoTask> tasks = TodoPage().getTasks();

  void _loadTasks() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/tasks.json';
      File file = File(filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        List<dynamic> decodedTasks = jsonDecode(content);
        List<TodoTask> loadedTasks = decodedTasks.map((task) => TodoTask.fromJson(task)).toList();
        tasks = loadedTasks;
      }
    } catch (e) {
      //FIXME: Tu powinien się wyświetlać na stronie TODO komunikat że się nie udało.
      print("Error loading tasks: $e");
    }
  }

  Padding _buildTaskItem(String taskText) {
    final randomColor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1.0,
    );

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: randomColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            taskText,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadTasks();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "STUDI",
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ),
            // Pozostała zawartość
            Container(
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Streak: 6 Dni🔥", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Łącznie nauki: 3h 57m", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Zostało dziś jeszcze: ",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "57% ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                    ),
                    Text(
                      "zadań.",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TodoTask todo = tasks[index];
                    if (todo.isCompleted) return null;
                    return SizedBox(
                      // Wrap the Container with a SizedBox
                      width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                      child: _buildTaskItem(todo.task),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dzisiaj to już na tyle!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
