import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../pages/screens/home_lay_out.dart';

class NotifyHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializeNotification() async {
    tz.initializeTimeZones();
    // tz.setLocal Location(tz.getLocation(timeZoneName));

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      selectNotification(payload!, context);
    });
  }

  void selectNotification(String payload, context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (context) => HomeScreen(payload: payload)),
    );
  }

  displayNotification(String title, String body) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  ScheduledNotifacation() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload, context) async {
// display a dialog with the notification details, tap ok to go to another page
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(payload: payload),
              ),
            );
          },
        )
      ],
    ),
  );
}
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

// if (kIsWeb || Platform.isLinux) {
// return;
// }
//
// final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
