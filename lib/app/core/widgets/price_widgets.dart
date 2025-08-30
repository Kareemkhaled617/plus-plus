import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plus/app/core/utils/size_config.dart';

/// ------- helpers
String _twoDecimals(num v) => NumberFormat("0.00").format(v);

/// Splits 57.75 -> ('57', '75')
({String intPart, String fracPart}) splitPrice(num value) {
  final s = _twoDecimals(value);
  final parts = s.split('.');
  return (intPart: parts[0], fracPart: parts.length > 1 ? parts[1] : '00');
}

/// ------- Discount badge (e.g. -11%)
class DiscountBadge extends StatelessWidget {
  final int percent; // pass positive number (11) and we'll show "-11%"
  final EdgeInsets padding;
  final double radius;

  const DiscountBadge({
    super.key,
    required this.percent,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFE53935), // red
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        '-$percent%',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// ------- Price row “EGP 57 75  (old price)”
class PriceRow extends StatelessWidget {
  final String currency; // "EGP"
  final num price; // 57.75
  final num? oldPrice; // 65.00
  final bool highlight; // lime background like screenshot

  const PriceRow({
    super.key,
    required this.currency,
    required this.price,
    this.oldPrice,
    this.highlight = true,
  });

  @override
  Widget build(BuildContext context) {
    final p = splitPrice(price);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // lime pill with current price
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: highlight ? const Color(0xFFDFF27A) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${currency.tr} ',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: .2,
                  ),
                ),
                TextSpan(
                  text: p.intPart,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  baseline: TextBaseline.alphabetic,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      p.fracPart,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: getProportionateScreenWidth(6)),

        // old price with strikethrough
        if (oldPrice != null)
          Flexible(
            child: Text(
              _twoDecimals(oldPrice!),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black38,
                decoration: TextDecoration.lineThrough,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

      ],
    );
  }
}

class PriceWithBadgeCard extends StatelessWidget {
  final String title; // e.g. "Elano Natural Water Pack"
  final String subTitle; // e.g. "1.5 L"
  final num price; // e.g. 57.75
  final num oldPrice; // e.g. 65.00
  final int discountPercent; // e.g. 11

  const PriceWithBadgeCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.oldPrice,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    )),
                const SizedBox(height: 4),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                PriceRow(
                  currency: 'EGP',
                  price: price,
                  oldPrice: oldPrice,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
