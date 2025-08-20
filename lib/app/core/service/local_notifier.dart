// lib/app/core/notifications/local_notifier.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifier {
  static final LocalNotifier _i = LocalNotifier._internal();
  factory LocalNotifier() => _i;
  LocalNotifier._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  // Future<void> init() async {
  //   const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const iOSSettings = DarwinInitializationSettings();
  //   const initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
  //
  //   await _plugin.initialize(
  //     initSettings,
  //     // You can handle taps via onDidReceiveNotificationResponse if needed
  //   );
  // }

  Future<void> notifyOrderDone(int orderId, {String? orderNumber}) async {
    const androidDetails = AndroidNotificationDetails(
      'order_done_channel',
      'Order Status',
      channelDescription: 'Notify when an order countdown finishes',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSDetails = DarwinNotificationDetails();

    final details = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await _plugin.show(
      orderId, // unique id
      'Order #${orderNumber ?? orderId} is ready',
      'Countdown finished for order $orderId',
      details,
      payload: orderId.toString(), // you can pass orderId here
    );
  }
}
