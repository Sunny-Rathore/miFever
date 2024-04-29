import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/notification_service.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // await NotificationService.initialize();
    // NotificationService.showLocalNotification(message);
    // print('push Notification taped');
    // print(message.data['id']);
    //Get.to(() => ChatScreen('${message.data['id']}'));
  }

  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> initialize() async {
    await _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        // Handle the initial notification if available
        _handleNotification(message);
      }
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle any message received while the app is in the foreground
      _handleNotification(message);
    });
  }

  static Future<void> _handleNotification(RemoteMessage message) async {
    print("Push Notification==>");
    NotificationService.showLocalNotification(message);
  }

/* in some device or platform specially in web it may happen get token is
   not supported then you can put these condition to so that  you can not get
   any error in production */

  static Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required String id,
    required String type,
  }) async {
    var dio = Dio();
    var url = 'https://fcm.googleapis.com/fcm/send';
    var serverKey =
        'AAAAYjTniIQ:APA91bGbdvzwydRKLwKNvveCCiKsl5Fa4gQccZha5-GwYiRzwE3E-mM0GZbe6xH64QuVBAf_GtLKh73IMM6OJ0IyTalqCLNd7bSPgtqp2Mwes1UeTZlshQPeHEfM5_z3NoKUZD-qKIpz';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    var data = {
      'notification': {
        'body': body,
        'title': title,
        'sound': 'default',
        'vibrate': [200, 100, 200],
      },
      'to': token,
      'data': {
        'id': PrefUtils.getId(),
        'type': type
        // Custom payload data
      },
    };

    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully.');
      } else {
        debugPrint(
            'Notification sending failed with code: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  //get device token
  static Future<String?> generateToken() async {
    var notifyToken = await FirebaseMessaging.instance.isSupported()
        ? await FirebaseMessaging.instance.getToken()
        : "notifyToken";
    debugPrint('FCMTOKEN:::$notifyToken');
    return notifyToken;
  }
}
