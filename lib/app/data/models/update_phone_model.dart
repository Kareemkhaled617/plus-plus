import '../../domain/entities/update_phone_entity.dart';

class UpdatePhoneModel extends UpdatePhoneEntity {
  UpdatePhoneModel({required super.message});

  factory UpdatePhoneModel.fromJson(Map<String, dynamic> json) {
    return UpdatePhoneModel(message: json['message']);
  }
}
