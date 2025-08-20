// lib/app/modules/home_screen/arrival_timer/presentation/controller/order_countdown_controller.dart
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/service/local_notifier.dart';
import '../../../../../core/storage/secure_storage_helper.dart';
import '../../../../../domain/entities/order_entity.dart';

class OrderCountdownController extends GetxController {
  final List<OrderEntity> orders; // today’s orders
  OrderCountdownController(this.orders);

  final _secure = SecureStorageHelper();
  static const _persistKey = 'order_timers_state_v1';

  final currentIndex = 0.obs;
  final remaining = const Duration(seconds: 0).obs;
  final totalSeconds = 0.obs;
  final isActive = false.obs;

  late List<_Item> _items;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _prepare();
  }

  Future<void> _prepare() async {
    _items = orders.map((o) {
      final pair = _parseRange(o.estimatedDeliveryRange ?? '45-90 min');
      final maxMins = pair.$2; // max
      return _Item(
        orderId: o.id,
        orderNumber: o.orderNumber ?? '',
        maxMinutes: maxMins,
        estimatedDeliveryTime: o.estimatedDeliveryTime,
      );
    }).toList();

    // Load persisted state
    final jsonStr = await _secure.getData(_persistKey);
    if (jsonStr != null) {
      try {
        final saved = jsonDecode(jsonStr) as Map<String, dynamic>;
        currentIndex.value = (saved['currentIndex'] ?? 0) as int;
        final savedItems = (saved['items'] as List).cast<Map<String, dynamic>>();
        for (int i = 0; i < _items.length && i < savedItems.length; i++) {
          _items[i] = _items[i].copyWith(
            endAtMillis: savedItems[i]['endAtMillis'] as int?,
          );
        }
      } catch (_) {}
    }

    // Initialize endAt if missing – count from NOW + maxMinutes
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].endAtMillis == null) {
        final fallbackEnd = DateTime.now().add(Duration(minutes: _items[i].maxMinutes));
        _items[i] = _items[i].copyWith(endAtMillis: fallbackEnd.millisecondsSinceEpoch);

        // OPTIONAL: use server estimated_delivery_time as strict end time
        // final dt = _parseDate(_items[i].estimatedDeliveryTime);
        // final end = dt ?? fallbackEnd;
        // _items[i] = _items[i].copyWith(endAtMillis: end.millisecondsSinceEpoch);
      }
    }

    if (_items.isEmpty) {
      isActive.value = false;
      remaining.value = Duration.zero;
      totalSeconds.value = 0;
      return;
    }

    _start();
    await _persist();
  }

  void _start() {
    _timer?.cancel();
    isActive.value = true;
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() async {
    if (_items.isEmpty || currentIndex.value >= _items.length) {
      _finishAll();
      return;
    }

    final item = _items[currentIndex.value];
    final endAt = DateTime.fromMillisecondsSinceEpoch(item.endAtMillis!);
    final now = DateTime.now();
    final left = endAt.difference(now).inSeconds;

    totalSeconds.value = item.maxMinutes * 60;

    if (left <= 0) {
      await LocalNotifier().notifyOrderDone(item.orderId, orderNumber: item.orderNumber);
      currentIndex.value++;
      await _persist();
      if (currentIndex.value < _items.length) {
        _tick();
      } else {
        _finishAll();
      }
    } else {
      remaining.value = Duration(seconds: left);
    }
  }

  void _finishAll() {
    isActive.value = false;
    remaining.value = Duration.zero;
    totalSeconds.value = 0;
    _timer?.cancel();
  }

  Future<void> _persist() async {
    final data = {
      'currentIndex': currentIndex.value,
      'items': _items
          .map((e) => {
        'orderId': e.orderId,
        'orderNumber': e.orderNumber,
        'maxMinutes': e.maxMinutes,
        'endAtMillis': e.endAtMillis,
      })
          .toList(),
    };
    await _secure.saveData(_persistKey, jsonEncode(data));
  }

  (int, int) _parseRange(String s) {
    // returns (min, max)
    final r = RegExp(r'(\d+)\s*-\s*(\d+)');
    final m = r.firstMatch(s);
    if (m != null) {
      final a = int.tryParse(m.group(1)!) ?? 45;
      final b = int.tryParse(m.group(2)!) ?? 90;
      return (a < b ? a : b, a > b ? a : b);
    }
    return (45, 90);
  }

  DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(s, true).toLocal();
    } catch (_) {
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }
  }

  // ---------- Convenience for UI / Navigation ----------

  /// Human label
  String get currentOrderLabel {
    final it = _currentItemOrNull();
    if (it == null) return 'No active order';
    return 'Order #${it.orderNumber.isNotEmpty ? it.orderNumber : it.orderId}';
  }

  /// Current order id (null if no active order)
  int? get currentOrderId => _currentItemOrNull()?.orderId;

  /// Optional: expose a light view of the current order
  CurrentOrderView? get currentOrder {
    final it = _currentItemOrNull();
    if (it == null) return null;
    return CurrentOrderView(
      orderId: it.orderId,
      orderNumber: it.orderNumber,
      maxMinutes: it.maxMinutes,
      endAt: it.endAtMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(it.endAtMillis!)
          : null,
    );
  }

  _Item? _currentItemOrNull() {
    if (_items.isEmpty) return null;
    final idx = currentIndex.value;
    if (idx < 0 || idx >= _items.length) return null;
    return _items[idx];
  }
}

class _Item {
  final int orderId;
  final String orderNumber;
  final int maxMinutes;
  final String? estimatedDeliveryTime;
  final int? endAtMillis;

  _Item({
    required this.orderId,
    required this.orderNumber,
    required this.maxMinutes,
    this.estimatedDeliveryTime,
    this.endAtMillis,
  });

  _Item copyWith({
    int? orderId,
    String? orderNumber,
    int? maxMinutes,
    String? estimatedDeliveryTime,
    int? endAtMillis,
  }) {
    return _Item(
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      maxMinutes: maxMinutes ?? this.maxMinutes,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      endAtMillis: endAtMillis ?? this.endAtMillis,
    );
  }
}

/// Lightweight view for UI
class CurrentOrderView {
  final int orderId;
  final String orderNumber;
  final int maxMinutes;
  final DateTime? endAt;
  CurrentOrderView({
    required this.orderId,
    required this.orderNumber,
    required this.maxMinutes,
    required this.endAt,
  });
}
