import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/recent_search_entity.dart';
import '../controller/recent_search_controller.dart';

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
                style: AppFonts.hintText
                    .copyWith(fontSize: 14, color: AppColors.grey),
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
                  color: Colors.grey[200],
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
