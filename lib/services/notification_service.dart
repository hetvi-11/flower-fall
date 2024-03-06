import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id,a,b,c)async {
        print("onDidReceiveLocalNotification : $id");
        print("onDidReceiveLocalNotification : $a");
        print("onDidReceiveLocalNotification : $b");
        print("onDidReceiveLocalNotification : $c");
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // onSelectNotification: selectNotification

    // Future selectNotification(String payload) async {
    //   //Handle notification tapped logic here
    // }
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge:
          true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)

      subtitle: "Flower Fall",
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'period_notification',
      'period_notification',
      'Channel for notification',
      importance: Importance(1),
      priority: Priority(1),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      "Flower Fall App",
      "Track your periods!",
      platformChannelSpecifics,
    );
  }

  void setNotification({required List<CNotification> list}) async {
    int i = 1;
    list.forEach((notification) async {
      var time = tz.TZDateTime.from(notification.date, tz.local);
      if (time.isAfter(tz.TZDateTime.now(tz.local)) == true) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            i++,
            "${notification.title}",
            "${notification.message}",
            time,
            const NotificationDetails(
                android: AndroidNotificationDetails('period_notification',
                    'period_notification', 'Channel for notification')),
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    });
  }
}

class CNotification {
  DateTime date;
  String message;
  String title;
  CNotification(
      {required this.date, required this.message, required this.title});
}
