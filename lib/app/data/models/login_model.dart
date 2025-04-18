import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.code, required super.message});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      code: json['code'],
      message: json['message'],
    );
  }
}
