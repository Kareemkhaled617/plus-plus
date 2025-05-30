import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.avatar,
    required super.businessTypeId,
    required super.businessType,
    required super.points,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserProfileModel(
      id: user['id'],
      name: user['name'],
      phone: user['phone'],
      avatar: user['avatar'],
      businessTypeId: user['business_type_id'],
      businessType: user['business_type'],
      points: user['points'],
    );
  }
}
