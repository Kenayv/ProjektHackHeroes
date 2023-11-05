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
  late bool _hasSeenIntroduction=false;
  //user variables, will be stored in SharedPreferences
  late DateTime _lastLearnedDate;
  late bool _learnedToday;
  late bool _tasksFinishedToday;

  //user config variables, will be stored in SharedPreferences
  late int _configPrefHour;
  late int _configPrefDailyTasks;
  late int _configPrefDailyFlashCards;

  User() {
    _loadStats();
    _loadConfig();
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  //Loads user stats and saves them as variables in User class.
  Future<void> _loadStats() async {
    final SharedPreferences userStats = await SharedPreferences.getInstance();

    _statsHighScoreFlashCardsRush = userStats.getInt('highScoreFlashCardsRush') ?? 0;
    _statsCompletedFlashCards = userStats.getInt('completedFlashCards') ?? 0;
    _statsFinishedTasks = userStats.getInt('finishedTasks') ?? 0;
    _statsLongestStreak = userStats.getInt('longestStreak') ?? 0;
    _statsFailedTasks = userStats.getInt('failedTasks') ?? 0;
    _statsDayStreak = userStats.getInt('dayStreak') ?? 0;
    _hasSeenIntroduction = userStats.getBool('hasSeenIntroduction') ?? false;
  }

  //Loads user config and saves them as variables in User class.
  Future<void> _loadConfig() async {
    final SharedPreferences userConfig = await SharedPreferences.getInstance();

    _configPrefHour = userConfig.getInt('configPrefHour') ?? 18;
  }

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
    userStats.setBool('hasSeenIntroduction', _hasSeenIntroduction);
  }

  //Saves user stats as SharedPrefs.
  Future<void> _saveConfig() async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.
    final SharedPreferences userConfig = await SharedPreferences.getInstance();

    userConfig.setInt('configPrefHour', _configPrefHour);
  }

  //  -   -   -   -   ↓ Functions changing user's variables ↓    -   -   -   -   -   -

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



  Future <bool> getHasSeenIntroduction() async{

    await _loadStats();

    return _hasSeenIntroduction;
  }


  void setHasSeenIntroductionTrue(){
    _hasSeenIntroduction=true;
    _saveStats();
    print("thingy in setintroductiontotrue::");
    print(_hasSeenIntroduction);
  }

  void setHasSeenIntroductionFalse(){
    _hasSeenIntroduction=false;
    _saveStats();

  }









//  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
}

//User object that will
final User currentUser = User();