import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/app_keys.dart';

class RecentSearchSection extends StatelessWidget {
  const RecentSearchSection({
    super.key,
    this.onTap,
    required this.recentSearches,
  });

  final Function(String)? onTap;
  final List<String> recentSearches;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppKeys.recentSearch .tr,
                style: AppFonts.hintText.copyWith(fontSize: 14,color: AppColors.grey),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          /// **Recent Search Chips**
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: recentSearches.map((search) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                    onTap: () => onTap!(search),
                    child: Text(
                      search,
                      style: AppFonts.bodyText.copyWith(
                          fontSize: 14, color: Colors.grey.withOpacity(.8)),
                    )),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
