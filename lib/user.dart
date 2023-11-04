// ignore_for_file: unused_element, prefer_final_fields

import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  // WARNING: Those variables can be easily accessed and changed. They're found as SharedPreferences in the file system. It is not a problem though, as long, as there is no competetive use of those variables, such as friends leaderboard. The only "cheating" that can be done at the current state is user changing the variables for personal use.
  //user stats, will be stored in SharedPreferences
  late int _statsDayStreak;
  late int _statsFinishedTasks;
  late int _statsFailedTasks;
  late int _statsHighScoreFlashCardsRush;
  late int _statsCompletedFlashCards;
  late int _statsLongestStreak;

  //user variables, will be stored in SharedPreferences
  late DateTime _varLastLearnedDate;
  late DateTime _varLastDailyGoalCompletionDate;
  late int _varTasksFinishedToday;
  late int _varFlashCardsFinishedToday;
  late bool _varDailyGoalAchieved;

  //user config variables, will be stored in SharedPreferences
  late int _configPrefHour;
  late int _configPrefDailyTasks;
  late int _configPrefDailyFlashCards;

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  User() {
    _loadStats();
    _loadVars();
    _loadConfig();
  }

  //
  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  //

  //Loads user stats and saves them as variables in User class.
  Future<void> _loadStats() async {
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    _statsHighScoreFlashCardsRush = userStats.getInt('highScoreFlashCardsRush') ?? 0;
    _statsCompletedFlashCards = userStats.getInt('completedFlashCards') ?? 0;
    _statsFinishedTasks = userStats.getInt('finishedTasks') ?? 0;
    _statsLongestStreak = userStats.getInt('longestStreak') ?? 0;
    _statsFailedTasks = userStats.getInt('failedTasks') ?? 0;
    _statsDayStreak = userStats.getInt('dayStreak') ?? 0;
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  Future<void> _loadVars() async {
    final SharedPreferences userVars = await SharedPreferences.getInstance();

    final lastLearnedYear = userVars.getInt('lastLearnedYear') ?? 1999;
    final lastLearnedMonth = userVars.getInt('lastLearnedMonth') ?? 1;
    final lastLearnedDay = userVars.getInt('lastLearnedDay') ?? 1;
    _varLastLearnedDate = DateTime(lastLearnedYear, lastLearnedMonth, lastLearnedDay);

    if (_varLastLearnedDate.day != DateTime.now().day) {
      _varTasksFinishedToday = 0;
      _varFlashCardsFinishedToday = 0;
    }

    final lastGoalYear = userVars.getInt('lastGoalYear') ?? 1999;
    final lastGoalMonth = userVars.getInt('lastGoalMonth') ?? 1;
    final lastGoalDay = userVars.getInt('lastGoalDay') ?? 1;

    _varDailyGoalAchieved = _isDailyGoalCompleted(lastGoalYear, lastGoalMonth, lastGoalDay);
    if (!_varDailyGoalAchieved && lastGoalDay != DateTime.now().day - 1) _statsDayStreak = 0;
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  //Loads user config and saves them as variables in User class.
  Future<void> _loadConfig() async {
    final SharedPreferences userConfig = await SharedPreferences.getInstance();

    _configPrefHour = userConfig.getInt('configPrefHour') ?? 18;
    _configPrefDailyTasks = userConfig.getInt('configPrefDailyTasks') ?? 5;
    _configPrefDailyFlashCards = userConfig.getInt('configPrefFlashCards') ?? 20;
  }

  //
  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  //

  //Saves user stats as SharedPrefs.
  Future<void> _saveStats() async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    userStats.setInt('highScoreFlashCardsRush', _statsHighScoreFlashCardsRush);
    userStats.setInt('completedFlashCards', _statsCompletedFlashCards);
    userStats.setInt('longestStreak', _statsLongestStreak);
    userStats.setInt('failedTasks', _statsFailedTasks);
    userStats.setInt('finishedTasks', _statsFinishedTasks);
    userStats.setInt('dayStreak', _statsDayStreak);
  }

  //
  //  -   -   -   -   ↓ Functions changing user's variables ↓    -   -   -   -   -   -
  //

  bool _isDailyGoalCompleted(lastGoalYear, lastGoalMonth, lastGoalDay) {
    _varLastDailyGoalCompletionDate = DateTime(lastGoalYear, lastGoalMonth, lastGoalDay);

    switch (_varLastDailyGoalCompletionDate.day - DateTime.now().day) {
      case 0:
        return true;

      case 30:
        if (_varLastDailyGoalCompletionDate.month == DateTime.january ||
            _varLastDailyGoalCompletionDate.month == DateTime.march ||
            _varLastDailyGoalCompletionDate.month == DateTime.may ||
            _varLastDailyGoalCompletionDate.month == DateTime.july ||
            _varLastDailyGoalCompletionDate.month == DateTime.august ||
            _varLastDailyGoalCompletionDate.month == DateTime.october ||
            _varLastDailyGoalCompletionDate.month == DateTime.december) return true;

      case 29:
        if (_varLastDailyGoalCompletionDate.month == DateTime.april ||
            _varLastDailyGoalCompletionDate.month == DateTime.june ||
            _varLastDailyGoalCompletionDate.month == DateTime.september ||
            _varLastDailyGoalCompletionDate.month == DateTime.november) return true;

      case 28:
        if (_varLastDailyGoalCompletionDate.year % 4 == 0 && _varLastDailyGoalCompletionDate.month == DateTime.february)
          return true;

      case 27:
        if (_varLastDailyGoalCompletionDate.month == DateTime.february) return true;
    }
    return false;
  }

  updateFCRushHighScore(int highScore) {
    if (highScore <= 0) return;
    _statsHighScoreFlashCardsRush += highScore;
    _saveStats();
  }

  incrCompletedFlashCard() {
    _statsCompletedFlashCards++;
    _saveStats();
  }

  incrFinishedTask() {
    _statsFinishedTasks++;
    _saveStats();
  }

  decrFinishedTask() {
    _statsFinishedTasks--;
    _saveStats();
  }

  incrFailedTask() {
    _statsFailedTasks++;
    _saveStats();
  }

  _updateDaysStreak(int newDaysStreak) {
    if (newDaysStreak <= 0) return;
    if (_statsLongestStreak < newDaysStreak) _statsLongestStreak = newDaysStreak;
    _statsDayStreak = newDaysStreak;
    _saveStats();
  }

  //  -   -   -   -   ↓ Functions returning user's variables ↓    -   -   -   -   -   -

  int getDayStreak() {
    return _statsDayStreak;
  }

  int getCompletedFC() {
    return _statsCompletedFlashCards;
  }

  int getLongestStreak() {
    return _statsLongestStreak;
  }

  int getFailedTasks() {
    return _statsFailedTasks;
  }

  double getTaskCompletion() {
    if (_statsFinishedTasks == 0) return 0.00;
    if (_statsFailedTasks == 0) return 100;
    int totalTasks = _statsFailedTasks + _statsFinishedTasks;
    return _statsFinishedTasks / totalTasks * 100.00;
  }

  int getFinishedTasks() {
    return _statsFinishedTasks;
  }

  int getHighScoreFCRush() {
    return _statsHighScoreFlashCardsRush;
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
}

//User object that will
final User currentUser = User();
