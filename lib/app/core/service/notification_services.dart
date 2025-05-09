import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:get/get.dart';
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
      print(message.notification?.body);
      _showNotification(message);
      notificationMessages.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 🔥 Enable Firebase In-App Messaging
    _initializeInAppMessaging();
  }

  Future<void> _initializeInAppMessaging() async {
    // Enable automatic data collection for In-App Messaging
    await _inAppMessaging.setAutomaticDataCollectionEnabled(true);

    // Optionally trigger test messages during development
    await _inAppMessaging.triggerEvent('app_open');
    print('-------------------------------------------------------------------------------------------------3-0id');
    // You can trigger custom events as needed
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
  }
}
