import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import 'package:project_hack_heroes/user.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoTask> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/tasks.json';
      File file = File(filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        List<dynamic> decodedTasks = jsonDecode(content);
        List<TodoTask> loadedTasks = decodedTasks.map((task) => TodoTask.fromJson(task)).toList();
        if (mounted) {
          setState(() {
            tasks = loadedTasks;
          });
        }
      }
    } catch (e) {
      //FIXME: Tu powinien się wyświetlać na stronie TODO komunikat że się nie udało.
      print("Error loading tasks: $e");
    }
  }

  Padding _buildTaskItem(String taskText) {
    final randomColor = usertheme.taskcolor;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: randomColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            taskText,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: usertheme.primarybgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "STUDEE",
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: usertheme.textColor),
                  ),
                  Text(
                    "dzisiaj:",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: usertheme.textColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: 50,
                    child: Center(
                      child: Text("Streak: " + currentUser.getDayStreak().toString() + '🔥',
                          style: TextStyle(fontSize: 18, color: usertheme.textColor)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: 50,
                    child: Center(
                      child: Text(
                          "fiszek: " +
                              currentUser.getFlashCardsFinishedToday().toString() +
                              '/' +
                              currentUser.getFlashCardGoal().toString(),
                          style: TextStyle(fontSize: 18, color: usertheme.textColor)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: 50,
                    child: Center(
                      child: Text(
                          "zadań:" +
                              currentUser.getTasksFinishedToday().toString() +
                              '/' +
                              currentUser.getTasksGoal().toString(),
                          style: TextStyle(fontSize: 18, color: usertheme.textColor)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Zadania do ukończenia:",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: usertheme.textColor),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TodoTask todo = tasks[index];
                    if (todo.isCompleted) return null;
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: _buildTaskItem(todo.task),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
