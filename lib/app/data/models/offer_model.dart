import '../../domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  OfferModel({
    required super.offerId,
    required super.type,
    required super.image,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      offerId: json['offer_id'],
      type: json['type'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer_id': offerId,
      'type': type,
      'image': image,
    };
  }
}
