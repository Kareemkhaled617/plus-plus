import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.type,
    required super.readed,
    required super.date,
    required super.section,
    required super.notificationType,
    required super.productId,
    required super.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      body: json['message'] ?? '',
      type: json['type'] ?? '',
      readed: json['readed'] ?? false,
      date: json['date'] ?? '',
      section: json['section'] ?? '',
      notificationType: json['notification_type'] ?? '',
      productId: json['product_id'].toString(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': body,
      'type': type,
      'readed': readed,
      'date': date,
      'section': section,
      'notification_type': notificationType,
      'product_id': productId,
      'image': image,
    };
  }
}
