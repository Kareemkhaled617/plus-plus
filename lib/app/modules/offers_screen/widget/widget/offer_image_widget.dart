import 'package:flutter/material.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/widgets/cached_image.dart';

class OfferImageWidget extends StatelessWidget {
  const OfferImageWidget(
      {super.key, this.image, this.onTap, this.isCenter = false});

  final String? image;

  final VoidCallback? onTap;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        child: CachedImage(
          imageUrl: image!,
        ),
      ),
    );
  }
}
