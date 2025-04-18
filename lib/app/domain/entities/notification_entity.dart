class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool readed;
  final String date;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.readed,
    required this.date,
  });
}
