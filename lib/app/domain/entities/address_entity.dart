class AddressEntity {
  final int id;
  final String lat;
  final String lng;
  final String street;
  final String address;
  final String building;
  final String floor;
  final String department;
  final String setAs;

  AddressEntity({
    required this.id,
    required this.lat,
    required this.lng,
    required this.street,
    required this.address,
    required this.building,
    required this.floor,
    required this.department,
    required this.setAs,
  });
}
