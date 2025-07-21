class ArrivalTimerUseCase {
  final Duration estimatedDuration = const Duration(minutes: 60);

  DateTime getEndTime(DateTime startTime) {
    return startTime.add(estimatedDuration);
  }

  Duration getRemainingTime(DateTime startTime) {
    final endTime = getEndTime(startTime);
    final now = DateTime.now();
    return endTime.isAfter(now) ? endTime.difference(now) : Duration.zero;
  }
}
