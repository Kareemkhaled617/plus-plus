
class UserProfileEntity {
  final int id;
  final String name;
  final String phone;
  final String avatar;
  final int businessTypeId;
  final String businessType;
  final int points;

  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.businessTypeId,
    required this.businessType,
    required this.points,
  });
}
