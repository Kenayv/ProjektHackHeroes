import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }
}

void initNotifications() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'scheduled',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')
      ],
      debug: true);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  // // Only after at least the action method is set, the notification events are delivered
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
  );
}

// Jakiś tam testowy przycisk z funkcją repeatującą się co 60 sekund
/*
  void testowanko() async {
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'scheduled',
            title: 'Notification every single minute',
            body: 'This notification was scheduled to repeat every minute.',
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture: 'asset://assets/images/melted-clock.png'),
        schedule: NotificationInterval(interval: 60, timeZone: localTimeZone, repeats: true));
  }
  ElevatedButton(onPressed: () => testowanko(), child: Text("woooo")),
*/