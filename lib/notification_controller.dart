import 'package:awesome_notifications/awesome_notifications.dart';
import 'main.dart';
import 'user.dart';
import 'dart:math';

class NotificationController {
  static const int scheduledReminderId = 2;

  NotificationController() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

  //Randomizes notification message and sends it the next day at hour selected by user (defaultHour: 18:00)
  Future scheduleNextReminderNotificantion() async {
    final int currentStreak = currentUser.getDayStreak();
    final DateTime currentDate = DateTime.now();
    final List messages = [
      "Uwaga! Twój codzienny streak zbliża się do końca!",
      "Jeszcze kilka godzin do zakończenia twojego $currentStreak dniowego streaka!",
      "Czas biegnie, twój $currentStreak dniowy streak powoli zanika.",
      "Nie zapomnij o swoim dziennym celu - zbliża się koniec streaka!",
      "Masz chwilę, aby się pouczyć?",
      "Nie pozwól, aby twój codzienny streak się przerwał. Poucz się teraz!",
      "Streak nadal trwa, ale czas ucieka - działaj teraz!",
      "Twój $currentStreak dniowy streak zbliża się do końca, nie przerywaj go!",
    ];
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: scheduledReminderId,
        channelKey: 'scheduled',
        title: 'Czas na naukę!',
        body: messages[Random().nextInt(messages.length - 1)],
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/melted-clock.png',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day + 1,
          currentUser.getPrefHour(),
        ),
      ),
    );
    currentUser.switchUpcomingReminder();
  }

  //this function should be always called before app
  Future initNotifications() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // WARNING: This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    if (!currentUser.isReminderUpcoming()) noController.scheduleNextReminderNotificantion();
  }

  void cancelUpcomingReminders() {
    AwesomeNotifications().cancel(scheduledReminderId);
  }
}

NotificationController noController = NotificationController();
