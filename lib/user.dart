import 'package:project_hack_heroes/notification_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_hack_heroes/theme.dart';

class User {
  // WARNING: Those variables can be easily accessed and changed. They're found as SharedPreferences in the file system. It is not a problem though, as long, as there is no competetive use of those variables, such as friends-leaderboard. The only "cheating" that can be done at the current state is user changing the variables for personal use.

  //user stats, vars, and config variables. will be stored in SharedPreferences. Can be accessed via get...() function
  late int _statsHighScoreFlashCardsRush; //FIXME: WORK-IN-PROGRESS
  late int _statsCompletedFlashCards;
  late int _statsFinishedTasks;
  late int _statsLongestStreak;
  late int _statsFailedTasks;
  late int _statsDayStreak;
  late bool _hasSeenIntroduction;

  late DateTime _varLastDailyGoalCompletionDate;
  late DateTime _varLastLearnedDate;
  late bool _varDailyGoalAchieved;
  late int _varFlashCardsFinishedToday;
  late int _varTasksFinishedToday;
  late bool _upcomingNotification; //FIXME: WORK-IN-PROGRESS

  late String _configUserName;
  late int _configPrefDailyFlashCards;
  late int _configPrefDailyTasks;
  late int _configPrefHour;
  late int _configPrefMin;
  late String _configTheme;

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  User();

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  Future initUser() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    _loadConfig(sharedPrefs);
    _loadStats(sharedPrefs);
    _loadVars(sharedPrefs);
  }

  Future saveAll() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    _saveConfig(sharedPrefs);
    _saveStats(sharedPrefs);
    _saveVars(sharedPrefs);
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  //Loads user stats and saves them as variables in User class.
  Future<void> _loadStats(SharedPreferences sharedPrefs) async {
    _statsHighScoreFlashCardsRush = sharedPrefs.getInt('highScoreFlashCardsRush') ?? 0; //FIXME: WORK-IN-PROGRESS
    _statsCompletedFlashCards = sharedPrefs.getInt('completedFlashCards') ?? 0;
    _statsFinishedTasks = sharedPrefs.getInt('finishedTasks') ?? 0;
    _statsLongestStreak = sharedPrefs.getInt('longestStreak') ?? 0;
    _statsFailedTasks = sharedPrefs.getInt('failedTasks') ?? 0;
    _statsDayStreak = sharedPrefs.getInt('dayStreak') ?? 0;
    _hasSeenIntroduction = sharedPrefs.getBool('hasSeenIntroduction') ?? false;
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  Future<void> _loadVars(SharedPreferences sharedPrefs) async {
    final lastLearnedYear = sharedPrefs.getInt('lastLearnedYear') ?? 1999;
    final lastLearnedMonth = sharedPrefs.getInt('lastLearnedMonth') ?? 1;
    final lastLearnedDay = sharedPrefs.getInt('lastLearnedDay') ?? 1;
    _varLastLearnedDate = DateTime(lastLearnedYear, lastLearnedMonth, lastLearnedDay);

    if (_varLastLearnedDate.day != DateTime.now().day) {
      _varTasksFinishedToday = 0;
      _varFlashCardsFinishedToday = 0;
      sharedPrefs.setInt('tasksFinishedToday', _varTasksFinishedToday);
      sharedPrefs.setInt('flashCardsFinishedToday', _varFlashCardsFinishedToday);
    } else {
      _varTasksFinishedToday = sharedPrefs.getInt('tasksFinishedToday') ?? 0;
      _varFlashCardsFinishedToday = sharedPrefs.getInt('flashCardsFinishedToday') ?? 0;
    }

    final lastGoalYear = sharedPrefs.getInt('lastGoalYear') ?? 1999;
    final lastGoalMonth = sharedPrefs.getInt('lastGoalMonth') ?? 1;
    final lastGoalDay = sharedPrefs.getInt('lastGoalDay') ?? 1;
    _varDailyGoalAchieved = _isDailyGoalCompleted(lastGoalYear, lastGoalMonth, lastGoalDay);
    if (_varDailyGoalAchieved) noController.cancelUpcomingReminders();
    _upcomingNotification = sharedPrefs.getBool('upcomingNotification') ?? false;
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  //Loads user config and saves them as variables in User class.
  Future<void> _loadConfig(SharedPreferences sharedPrefs) async {
    _configPrefHour = sharedPrefs.getInt('configPrefHour') ?? 18;
    _configPrefMin = sharedPrefs.getInt('configPrefMin') ?? 0;
    _configPrefDailyTasks = sharedPrefs.getInt('configPrefDailyTasks') ?? 5;
    _configPrefDailyFlashCards = sharedPrefs.getInt('configPrefFlashCards') ?? 20;
    _configUserName = sharedPrefs.getString("configUserName") ?? "Hello dolly!";
    _configTheme = sharedPrefs.getString("configTheme") ?? "White";
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  //Saves user stats as SharedPrefs.
  Future<void> _saveStats(SharedPreferences sharedPrefs) async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.

    sharedPrefs.setInt('highScoreFlashCardsRush', _statsHighScoreFlashCardsRush); //FIXME: WORK-IN-PROGRESS
    sharedPrefs.setInt('completedFlashCards', _statsCompletedFlashCards);
    sharedPrefs.setInt('longestStreak', _statsLongestStreak);
    sharedPrefs.setInt('finishedTasks', _statsFinishedTasks);
    sharedPrefs.setInt('failedTasks', _statsFailedTasks);
    sharedPrefs.setInt('dayStreak', _statsDayStreak);
    sharedPrefs.setBool('hasSeenIntroduction', _hasSeenIntroduction);
    _varLastLearnedDate = DateTime.now();
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  Future<void> _saveVars(SharedPreferences sharedPrefs) async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.

    final lastGoalYear = sharedPrefs.getInt('lastGoalYear') ?? 1999;
    final lastGoalMonth = sharedPrefs.getInt('lastGoalMonth') ?? 1;
    final lastGoalDay = sharedPrefs.getInt('lastGoalDay') ?? 1;
    _varDailyGoalAchieved = _isDailyGoalCompleted(lastGoalYear, lastGoalMonth, lastGoalDay);
    if (_varDailyGoalAchieved) noController.cancelUpcomingReminders();

    sharedPrefs.setInt('lastLearnedYear', _varLastLearnedDate.year);
    sharedPrefs.setInt('lastLearnedMonth', _varLastLearnedDate.month);
    sharedPrefs.setInt('lastLearnedDay', _varLastLearnedDate.day);

    sharedPrefs.setInt('tasksFinishedToday', _varTasksFinishedToday);
    sharedPrefs.setInt('flashCardsFinishedToday', _varFlashCardsFinishedToday);
    sharedPrefs.setBool('upcomingNotification', _upcomingNotification);
  }

  //  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

  Future<void> _saveConfig(SharedPreferences sharedPrefs) async {
    //WARNING: this function might be very sub-optimal, because it is invoked on every User variable change. If it happens to be visibly laggy, only changed variable should be updated as SharedPref. For now, the definition can stay as it is for the sake of simplicity.

    sharedPrefs.setString('configUserName', _configUserName);
    sharedPrefs.setInt('configPrefDailyFlashCards', _configPrefDailyFlashCards);
    sharedPrefs.setInt('configPrefDailyTasks', _configPrefDailyTasks);
    sharedPrefs.setInt('configPrefHour', _configPrefHour);
    sharedPrefs.setInt('configPrefMin', _configPrefMin);
    sharedPrefs.setString("configTheme", _configTheme);
  }

  //  -   -   -   -   ↓ Functions changing user's variables ↓    -   -   -   -   -   -

  bool _isDailyGoalCompleted(lastGoalYear, lastGoalMonth, lastGoalDay) {
    if (_varTasksFinishedToday >= _configPrefDailyTasks && _varFlashCardsFinishedToday >= _configPrefDailyFlashCards) {
      return true;
    }

    _varLastDailyGoalCompletionDate = DateTime(lastGoalYear, lastGoalMonth, lastGoalDay);

    switch (_varLastDailyGoalCompletionDate.day - DateTime.now().day) {
      //if DailyGoal was completed today
      case 0:
        _statsDayStreak = 0;
        return true;

      //case -1 simply returns false and doesnt change dayStreak, because the user has studied yesterday and can keep the streak up today.
      case -1:
        return false;

      //if the last month was 31 days long, and has just ended
      case 30:
        if (_varLastDailyGoalCompletionDate.month == DateTime.january ||
            _varLastDailyGoalCompletionDate.month == DateTime.march ||
            _varLastDailyGoalCompletionDate.month == DateTime.may ||
            _varLastDailyGoalCompletionDate.month == DateTime.july ||
            _varLastDailyGoalCompletionDate.month == DateTime.august ||
            _varLastDailyGoalCompletionDate.month == DateTime.october ||
            _varLastDailyGoalCompletionDate.month == DateTime.december) return true;

      //if the last month was 30 days long, and has just ended
      case 29:
        if (_varLastDailyGoalCompletionDate.month == DateTime.april ||
            _varLastDailyGoalCompletionDate.month == DateTime.june ||
            _varLastDailyGoalCompletionDate.month == DateTime.september ||
            _varLastDailyGoalCompletionDate.month == DateTime.november) return true;

      //if the last month was 29 days long, and it's a leap year, skip to case 27:
      case 28:
        if (_varLastDailyGoalCompletionDate.year % 4 == 0 &&
            _varLastDailyGoalCompletionDate.month == DateTime.february) {
          return true;
        }

      //if the last month was 28 days long and it was february
      case 27:
        if (_varLastDailyGoalCompletionDate.month == DateTime.february) return true;
    }

    _statsDayStreak = 0;
    return false;
  }

  //  -   -   -   -   -   -   -   -   -   -

  void achieveDailyGoal() {
    if (!_varDailyGoalAchieved) {
      _varDailyGoalAchieved = true;
      _updateDaysStreak(_statsDayStreak + 1);
    }
  }
  //  -   -   -   -   -   -   -   -   -   -

  //FIXME: WORK-IN-PROGRESS
  void updateFCRushHighScore(int highScore) {
    if (highScore <= 0) return;
    _statsHighScoreFlashCardsRush += highScore;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void incrCompletedFlashCard() {
    _statsCompletedFlashCards++;
    _varFlashCardsFinishedToday++;
    if (_varFlashCardsFinishedToday == _configPrefDailyFlashCards && _varTasksFinishedToday == _configPrefDailyTasks) {
      achieveDailyGoal();
    }
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void incrFinishedTask() {
    _statsFinishedTasks++;
    _varTasksFinishedToday++;
    if (_varFlashCardsFinishedToday == _configPrefDailyFlashCards && _varTasksFinishedToday == _configPrefDailyTasks) {
      achieveDailyGoal();
    }
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void decrFinishedTask() {
    _statsFinishedTasks--;
    _varTasksFinishedToday--;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void incrFailedTask() {
    _statsFailedTasks++;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void switchUpcomingReminder() {
    _upcomingNotification = !_upcomingNotification;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void _updateDaysStreak(int newDaysStreak) {
    if (newDaysStreak <= 0) return;
    if (_statsLongestStreak < newDaysStreak) _statsLongestStreak = newDaysStreak;
    _statsDayStreak = newDaysStreak;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void setPrefHour(int h) {
    _configPrefHour = h;
    saveAll();
  }

  //  -   -   -   -   -   -   -   -   -   -

  void setPrefMin(int mins) {
    _configPrefMin = mins;
    saveAll();
  }

  void setName(String s) {
    _configUserName = s;
    saveAll();
  }

  void setTheme(String s) {
    if (s == "White") {
      _configTheme = "White";
    } else if (s == "Black") {
      _configTheme = "Black";
    } else {
      _configTheme = "Error";
    }
    usertheme = (currentUser.getTheme() == "White" ? whitetheme : blacktheme);
    saveAll();
  }

  //  -   -   -   -   ↓ Functions returning user's variables ↓    -   -   -   -   -   -

  int getDayStreak() {
    return _statsDayStreak;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getCompletedFC() {
    return _statsCompletedFlashCards;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getLongestStreak() {
    return _statsLongestStreak;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getFailedTasks() {
    return _statsFailedTasks;
  }

  //  -   -   -   -   -   -   -   -   -   -

  double getTaskCompletion() {
    if (_statsFinishedTasks == 0) return 0.00;
    if (_statsFailedTasks == 0) return 100;
    int totalTasks = _statsFailedTasks + _statsFinishedTasks;
    return _statsFinishedTasks / totalTasks * 100.00;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getFinishedTasks() {
    return _statsFinishedTasks;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getHighScoreFCRush() {
    return _statsHighScoreFlashCardsRush;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getTasksFinishedToday() {
    return _varTasksFinishedToday;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getFlashCardsFinishedToday() {
    return _varFlashCardsFinishedToday;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getTasksGoal() {
    return _configPrefDailyTasks;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getFlashCardGoal() {
    return _configPrefDailyFlashCards;
  }

  //  -   -   -   -   -   -   -   -   -   -

  bool isReminderUpcoming() {
    return _upcomingNotification;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getPrefHour() {
    return _configPrefHour;
  }

  //  -   -   -   -   -   -   -   -   -   -

  int getPrefMin() {
    return _configPrefMin;
  }

  //  -   -   -   -   -   -   -   -   -   -

  bool isDailyGoalAchieved() {
    return _varDailyGoalAchieved;
  }

  Future<bool> getHasSeenIntroduction() async {
    return _hasSeenIntroduction;
  }

  void setHasSeenIntroductionTrue() {
    _hasSeenIntroduction = true;
    saveAll();
  }

  void setHasSeenIntroductionFalse() {
    _hasSeenIntroduction = false;
    saveAll();
  }

  bool hasSeenIntroduction() {
    return _hasSeenIntroduction;
  }

  String getName() {
    return _configUserName;
  }

  String getTheme() {
    return _configTheme;
  }
}

final User currentUser = User();
