import 'package:flutter/material.dart';

/// Place this inside a Stack and position it at the topRight:
/// Positioned(top: 0, right: 0, child: CornerDiscountBadge(text: '5% OFF'))
class CornerDiscountBadge extends StatelessWidget {
  const CornerDiscountBadge({
    super.key,
    required this.text,
    this.color = const Color(0xFFE56E22), // orange
    this.textStyle,
    this.height = 28,
    this.width = 88,
    this.innerCutRadius = 14, // the white curved “cut” radius
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  });

  final String text;
  final Color color;
  final TextStyle? textStyle;
  final double height;
  final double width;
  final double innerCutRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CornerBadgeClipper(innerCutRadius),
      child: Container(
        height: height,
        width: width,
        color: color,
        padding: padding,
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textStyle ??
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
              ),
        ),
      ),
    );
  }
}

/// Cuts a quarter‑circle from the bottom‑left of the badge so it
/// looks like it’s hugging the rounded card corner.
class _CornerBadgeClipper extends CustomClipper<Path> {
  _CornerBadgeClipper(this.r);
  final double r;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
    // start top-left
      ..moveTo(0, 0)
    // top edge to top-right
      ..lineTo(w, 0)
    // right edge to bottom-right
      ..lineTo(w, h)
    // bottom edge to bottom-left “before the cut”
      ..lineTo(r, h)
    // draw the inner white cut as a quarter circle to (0, h - r)
      ..arcToPoint(
        Offset(0, h - r),
        radius: Radius.circular(r),
        clockwise: false,
      )
    // up to top-left
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_CornerBadgeClipper oldClipper) => oldClipper.r != r;
}
