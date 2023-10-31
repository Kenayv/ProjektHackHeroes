// ignore_for_file: prefer_final_fields, unused_field

class User {
  var _userName = "";

  // User Stats
  var hoursLearned = 0;
  var dayStreak = 0;
  var favourite = "none";
  var finishedTasks = 0;
  var failedTasks = 0;
  var highScorefcRush = 0;
  var completedfc = 0;
  var longestStreak = 0;

  User(this._userName) {
    loadTasks();
  }

  void saveTasks() {}
  void loadTasks() {}
}
