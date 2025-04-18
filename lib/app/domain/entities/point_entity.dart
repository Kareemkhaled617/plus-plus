// lib/domain/entities/point_entity.dart
class PointEntity {
  final int id;
  final int points;
  final String orderNumber;
  final String type;
  final bool positive;
  final String date;

  PointEntity({
    required this.id,
    required this.points,
    required this.orderNumber,
    required this.type,
    required this.positive,
    required this.date,
  });
}

class PointDataEntity {
  final List<PointEntity> points;
  final int userPoints;

  PointDataEntity({
    required this.points,
    required this.userPoints,
  });
}
