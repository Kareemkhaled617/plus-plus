import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.code, required super.message, required super.newUser});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      code: json['code'],
      message: json['message'],
      newUser: json['is_new_user'],
    );
  }
}
