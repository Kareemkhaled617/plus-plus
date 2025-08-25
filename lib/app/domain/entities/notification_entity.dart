class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool readed;
  final String date;
  final String section;
  final String notificationType;
  final String productId;
  final String image;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.readed,
    required this.date,
    required this.section,
    required this.notificationType,
    required this.productId,
    required this.image,
  });
}
