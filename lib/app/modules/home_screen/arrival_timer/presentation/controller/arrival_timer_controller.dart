import 'dart:async';
import 'package:get/get.dart';
import '../../../arrival_timer/data/storage_service.dart';
import '../../../arrival_timer/domain/arrival_timer_usecase.dart';

class ArrivalTimerController extends GetxController {
  final _remaining = Duration(minutes: 60).obs;
  Duration get remaining => _remaining.value;

  late Timer _timer;
  final _storage = StorageService();
  final _useCase = ArrivalTimerUseCase();

  @override
  void onInit() {
    super.onInit();
    _initTimer();
  }

  Future<void> _initTimer() async {
    DateTime? startTime = await _storage.getStartTime();
    if (startTime == null) {
      startTime = DateTime.now();
      await _storage.saveStartTime(startTime);
    }

    _startCountdown(startTime);
  }

  void _startCountdown(DateTime startTime) {
    _remaining.value = _useCase.getRemainingTime(startTime);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = _useCase.getRemainingTime(startTime);
      if (duration.inSeconds <= 0) {
        _timer.cancel();
        _remaining.value = Duration.zero;
      } else {
        _remaining.value = duration;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
