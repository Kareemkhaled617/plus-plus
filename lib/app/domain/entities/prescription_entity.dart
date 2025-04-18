class PrescriptionEntity {
  final int id;
  final String image;
  final String aboutImage;
  final String imageType;
  final String status;
  final String statusNumber;
  final String orderProductNames;
  final String createdAt;

  PrescriptionEntity({
    required this.id,
    required this.image,
    required this.aboutImage,
    required this.imageType,
    required this.status,
    required this.statusNumber,
    required this.orderProductNames,
    required this.createdAt,
  });
}
