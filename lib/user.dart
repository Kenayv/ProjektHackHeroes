// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';

class User {
  // WARNING: Those variables can be easily accessed and changed. They're found as SharedPreferences in the file system. It is not a problem though, as long, as there is no competetive use of those variables, such as friends leaderboard. The only "cheating" that can be done at the current state is user changing them for personal use.
  late int _dayStreak = 0;
  late int _finishedTasks = 0;
  late int _failedTasks = 0;
  late int _highScoreFlashCardsRush = 0;
  late int _completedFlashCards = 0;
  late int _longestStreak = 0;

  User() {
    _loadStats();
  }

  //Loads user stats and saves them as variables in User class.
  Future<void> _loadStats() async {
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    _highScoreFlashCardsRush = userStats.getInt('highScoreFlashCardsRush') ?? 0;
    _completedFlashCards = userStats.getInt('completedFlashCards') ?? 0;
    _finishedTasks = userStats.getInt('finishedTasks') ?? 0;
    _longestStreak = userStats.getInt('longestStreak') ?? 0;
    _failedTasks = userStats.getInt('failedTasks') ?? 0;
    _dayStreak = userStats.getInt('dayStreak') ?? 0;
  }

  //Saves user stats as SharedPrefs.
  Future<void> _saveStats() async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    userStats.setInt('highScoreFlashCardsRush', _highScoreFlashCardsRush);
    userStats.setInt('completedFlashCards', _completedFlashCards);
    userStats.setInt('longestStreak', _longestStreak);
    userStats.setInt('failedTasks', _failedTasks);
    userStats.setInt('finishedTasks', _finishedTasks);
    userStats.setInt('dayStreak', _dayStreak);
  }

  addFlashCardHighScore(int highScore) {
    if (highScore <= 0) return;
    _highScoreFlashCardsRush += highScore;
    _saveStats();
  }

  addCompletedFlashCard() {
    _completedFlashCards++;
    _saveStats();
  }

  addFinishedTask() {
    _finishedTasks++;
    _saveStats();
  }

  removeFinishedTask() {
    _finishedTasks--;
    _saveStats();
  }

  addFailedTask() {
    _failedTasks++;
    _saveStats();
  }

  _updateDaysStreak(int newDaysStreak) {
    if (newDaysStreak <= 0) return;
    if (_longestStreak < newDaysStreak) _longestStreak = newDaysStreak;
    _dayStreak = newDaysStreak;
    _saveStats();
  }

  int getDayStreak() {
    return _dayStreak;
  }

  int getCompletedFC() {
    return _completedFlashCards;
  }

  int getLongestStreak() {
    return _longestStreak;
  }

  int getFailedTasks() {
    return _failedTasks;
  }

  double getTaskCompletion() {
    if (_finishedTasks == 0) return 0.00;
    if (_failedTasks == 0) return 100;
    int totalTasks = _failedTasks + _finishedTasks;
    return _finishedTasks / totalTasks * 100.00;
  }

  int getFinishedTasks() {
    return _finishedTasks;
  }

  int getHighScoreFCRush() {
    return _highScoreFlashCardsRush;
  }
}

final User currentUser = User();
