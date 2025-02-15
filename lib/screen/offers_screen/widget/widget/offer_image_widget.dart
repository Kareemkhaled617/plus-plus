import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class OfferImageWidget extends StatelessWidget {
  const OfferImageWidget({super.key, this.image, this.onTap, this.isCenter = false});

  final String? image;

  final VoidCallback? onTap;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Image.asset(
        image??Assets.tempOffers,
        fit: BoxFit.contain,
        height: isCenter ? 200 : 150,
      ),
    );
  }
}
