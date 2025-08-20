// lib/app/modules/orders/timer/order_timer_storage.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderTimerStorage {
  static const _key = 'order_timers_state';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveState(Map<String, dynamic> state) async {
    await _storage.write(key: _key, value: jsonEncode(state));
  }

  Future<Map<String, dynamic>?> loadState() async {
    final s = await _storage.read(key: _key);
    if (s == null) return null;
    return jsonDecode(s) as Map<String, dynamic>;
  }

  Future<void> clear() async => _storage.delete(key: _key);
}
