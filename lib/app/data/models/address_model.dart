import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.street,
    required super.address,
    required super.building,
    required super.floor,
    required super.department,
    required super.setAs,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      lat: json['lat'],
      lng: json['lng'],
      street: json['street'],
      address: json['address'],
      building: json['building'],
      floor: json['floor'],
      department: json['department'],
      setAs: json['set_as'],
    );
  }
}
