import 'address_entity.dart';

class DefaultAddressEntity {
  final AddressEntity address;
  final bool availableForDelivery;

  DefaultAddressEntity({
    required this.address,
    required this.availableForDelivery,
  });
}