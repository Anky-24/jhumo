import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_notification"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void display(RemoteMessage message) async {
    try {
      NotificationDetails notificationDetails;
      if (message.data["image"] != null) {
        final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl(message.data["image"]));
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl(message.data["image"]));
        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(
          bigPicture,
          largeIcon: largeIcon,
          contentTitle: message.data["title"],
          summaryText: message.data["body"],
        );
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails('jhumo', 'jhumochannel',
                styleInformation: bigPictureStyleInformation);
        notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
      } else {
        notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            "jhumo",
            "jhumochannel",
            importance: Importance.max,
            priority: Priority.high,
          ),
        );
      }
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await _notificationsPlugin.show(
        id,
        message.data["title"],
        message.data["body"],
        notificationDetails,
      );
    } on Exception catch (_) {
      // print(e);
    }
  }
}
