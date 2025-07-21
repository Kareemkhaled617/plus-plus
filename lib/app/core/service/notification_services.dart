import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../firebase_options.dart';

class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseInAppMessaging _inAppMessaging = FirebaseInAppMessaging.instance;

  var notificationMessages = <RemoteMessage>[].obs;

  Future<void> initNotification() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    getToken();

    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const DarwinInitializationSettings iosInitSettings = DarwinInitializationSettings();
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📥 Notification received with image: ${message.notification?.android?.imageUrl}");
      _showNotification(message);
      notificationMessages.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _initializeInAppMessaging();
  }

  Future<void> _initializeInAppMessaging() async {
    await _inAppMessaging.setAutomaticDataCollectionEnabled(true);
    await _inAppMessaging.triggerEvent('app_open');
    print('🔥 In-App Messaging Initialized');
  }

  Future<void> _showNotification(RemoteMessage message) async {
    String? imageUrl = message.notification?.android?.imageUrl ?? message.data['imageUrl'];

    // Download image to display in the notification
    BigPictureStyleInformation? bigPictureStyle;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final String imagePath = await _downloadAndSaveFile(imageUrl, 'notif_image.jpg');
        final FilePathAndroidBitmap bigPicture = FilePathAndroidBitmap(imagePath);

        bigPictureStyle = BigPictureStyleInformation(
          bigPicture,
          contentTitle: message.notification?.title,
          summaryText: message.notification?.body,
        );
      } catch (e) {
        print("❌ Failed to load image for notification: $e");
      }
    }

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      styleInformation: bigPictureStyle,
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    final NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getTemporaryDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('🕶️ Background message received: ${message.messageId}');
  }

  Future<void> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("🔐 FCM Token: $token");
  }
}
