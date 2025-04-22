// data/models/default_address_model.dart
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/default_address_entity.dart';

class DefaultAddressModel extends DefaultAddressEntity {
  DefaultAddressModel({
    required AddressModel super.address,
    required super.availableForDelivery,
  });

  factory DefaultAddressModel.fromJson(Map<String, dynamic> json) {
    return DefaultAddressModel(
      address: AddressModel.fromJson(json['address']),
      availableForDelivery: json['available_for_delivery'],
    );
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.address,
    required super.street,
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
      address: json['address'],
      street: json['street'],
      building: json['building'],
      floor: json['floor'],
      department: json['department'],
      setAs: json['set_as'],
    );
  }
}
