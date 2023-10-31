// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';

class User {
  // WARNING: Those variables can be easily accessed and changed. They're found as SharedPreferences in the file system. It is not a problem though, as long, as there is no competetive use of those variables, such as friends leaderboard. The only "cheating" that can be done at the current state is user changing them for personal use.
  late int _dayStreak;
  late int _finishedTasks;
  late int _failedTasks;
  late int _highScoreFlashCardsRush;
  late int _completedFlashCards;
  late int _longestStreak;

  User() {
    loadStats();
  }

  //Loads user stats and saves them as variables in User class.
  Future<void> loadStats() async {
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    _highScoreFlashCardsRush = userStats.getInt('highScoreFlashCardsRush') ?? 0;
    _completedFlashCards = userStats.getInt('completedFlashCards') ?? 0;
    _finishedTasks = userStats.getInt('finishedTasks') ?? 0;
    _longestStreak = userStats.getInt('longestStreak') ?? 0;
    _failedTasks = userStats.getInt('failedTasks') ?? 0;
    _dayStreak = userStats.getInt('dayStreak') ?? 0;
  }

  //Saves user stats as SharedPrefs.
  Future<void> saveStats() async {
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
    saveStats();
  }

  addCompletedFlashCard() {
    _completedFlashCards++;
    saveStats();
  }

  addFinishedTask() {
    _finishedTasks++;
    saveStats();
  }

  _updateDaysStreak(int newDaysStreak) {
    if (newDaysStreak <= 0) return;
    if (_longestStreak < newDaysStreak) _longestStreak = newDaysStreak;
    _dayStreak = newDaysStreak;
    saveStats();
  }

  addFailedTask() {
    _failedTasks++;
    saveStats();
  }
}

final User currentUser = User();
