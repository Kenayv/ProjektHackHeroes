import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:project_hack_heroes/theme.dart';
import 'package:project_hack_heroes/user.dart';
>>>>>>> ostatnie_szlify
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'todo_page.dart';
import 'dart:math';
import 'dart:io';

<<<<<<< HEAD
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
=======
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        setState(() {
          tasks = loadedTasks;
        });
      }
    } catch (e) {
      //FIXME: Tu powinien się wyświetlać na stronie TODO komunikat że się nie udało.
      print("Error loading tasks: $e");
    }
  }

  Padding _buildTaskItem(String taskText) {
    final randomColor = usertheme.Taskcolor;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: randomColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            taskText,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
>>>>>>> ostatnie_szlify
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadTasks();
    return Scaffold(
        backgroundColor: usertheme.Primarybgcolor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "STUDEE",
                        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                      ),
                      Text(
                        "dzisiaj:",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: usertheme.TextColor),
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
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: 50,
                          child: Center(
                            child: Text("Streak: " + currentUser.getDayStreak().toString() + '🔥',
                                style: TextStyle(fontSize: 18, color: usertheme.TextColor)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: 50,
                          child: Center(
                            child: Text(
                                "fiszek: " +
                                    currentUser.getFlashCardsFinishedToday().toString() +
                                    '/' +
                                    currentUser.getFlashCardGoal().toString(),
                                style: TextStyle(fontSize: 18, color: usertheme.TextColor)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: 50,
                          child: Center(
                            child: Text(
                                "zadań:" +
                                    currentUser.getTasksFinishedToday().toString() +
                                    '/' +
                                    currentUser.getTasksGoal().toString(),
                                style: TextStyle(fontSize: 18, color: usertheme.TextColor)),
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
                          "Zadania do ukończenia:",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: usertheme.TextColor),
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
                          width: MediaQuery.of(context).size.width * 0.7, // Set width to 80% of the screen width
                          child: _buildTaskItem(todo.task),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
