// lib/data/models/point_model.dart
import '../../domain/entities/point_entity.dart';

class PointModel extends PointEntity {
  PointModel({
    required super.id,
    required super.points,
    required super.orderNumber,
    required super.type,
    required super.positive,
    required super.date,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: json['id'],
      points: json['points'],
      orderNumber: json['order_number'],
      type: json['type'],
      positive: json['positive'],
      date: json['date'],
    );
  }
}

class PointDataModel extends PointDataEntity {
  PointDataModel({
    required super.points,
    required super.userPoints,
  });

  factory PointDataModel.fromJson(Map<String, dynamic> json) {
    final pointsList = json['points'] as List<dynamic>;
    return PointDataModel(
      points: pointsList.map((e) => PointModel.fromJson(e)).toList(),
      userPoints: json['user_points'],
    );
  }
}
