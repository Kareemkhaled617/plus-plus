import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/recent_search_entity.dart';

class RecentSearchSection extends StatelessWidget {
  const RecentSearchSection({
    super.key,
    this.onTap,
    required this.recentSearches,
  });

  final Function(String)? onTap;
  final List<RecentSearchEntity> recentSearches;

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
                AppKeys.recentSearch.tr,
                style: AppFonts.hintText.copyWith(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: recentSearches.map((search) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                    onTap: () => onTap!(search.searchTerm),
                    child: Text(
                      search.searchTerm,
                      style: AppFonts.bodyText.copyWith(
                          fontSize: 14, color: Colors.grey.withOpacity(.8)),
                    )),
              );
            }).toList(),
          )
        ],
      ],
    );
  }
}
