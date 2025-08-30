import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/modules/search_screen/widgets/recent_search_section.dart';
import 'package:plus/app/modules/search_screen/widgets/search_and_suggestion_section.dart';
import 'package:plus/app/modules/search_screen/widgets/searched_products_section.dart';

import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/loader.dart';
import '../../core/widgets/product_shimmer.dart';
import 'controller/recent_search_controller.dart';
import 'controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  bool isSearching = false;
  bool showResults = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recentController = Get.find<RecentSearchController>();
    final controller = Get.find<SearchProductController>();

    return Scaffold(
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     color: Color(0xFFEAF0F0),
      //   ),
      //   // title: Text(
      //   //   AppKeys.howCanHelpYou.tr,
      //   //   style: AppFonts.heading3.copyWith(
      //   //     fontWeight: FontWeight.w700,
      //   //   ),
      //   // ),
      //   leading: Container(),
      // ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
              decoration:BoxDecoration(
                color: Color(0xFFEAF0F0)
              ),
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  Row(
                    children: [
                      Expanded(
                        child: SearchAndSuggestionSection(
                          controller: searchController,
                          // suggestions: controller.isLoading.value
                          //     ? []
                          //     : controller.searchResults
                          //         .map((recent) => recent.name)
                          //         .toList(),
                          suggestions: [],
                          searchQuery: searchQuery,
                          onHintSelected: (selected) {
                            setState(() {
                              searchQuery = selected;
                              searchController.text = selected;
                              showResults = true;
                              isSearching = false;
                              controller.searchProducts(searchQuery);
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              showResults = true;
                              isSearching = value.isNotEmpty;
                            });
                            // showResults = true;
                            // isSearching = false;
                            //
                            controller.searchProducts(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          showResults = true;
                          isSearching = false;

                          controller.searchProducts(searchQuery);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  // Obx(() {
                  //   return Row(
                  //     children: [
                  //       Expanded(
                  //         child: SearchAndSuggestionSection(
                  //           controller: searchController,
                  //           // suggestions: controller.isLoading.value
                  //           //     ? []
                  //           //     : controller.searchResults
                  //           //         .map((recent) => recent.name)
                  //           //         .toList(),
                  //           suggestions: [],
                  //           searchQuery: searchQuery,
                  //           onHintSelected: (selected) {
                  //             setState(() {
                  //               searchQuery = selected;
                  //               searchController.text = selected;
                  //               showResults = true;
                  //               isSearching = false;
                  //               controller.searchProducts(searchQuery);
                  //             });
                  //           },
                  //           onChanged: (value) {
                  //             setState(() {
                  //               searchQuery = value;
                  //               showResults = true;
                  //               isSearching = value.isNotEmpty;
                  //             });
                  //             // showResults = true;
                  //             // isSearching = false;
                  //             //
                  //             controller.searchProducts(value);
                  //           },
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.search,
                  //           color: AppColors.primary,
                  //         ),
                  //         onPressed: () {
                  //           showResults = true;
                  //           isSearching = false;
                  //
                  //           controller.searchProducts(searchQuery);
                  //           setState(() {});
                  //         },
                  //       )
                  //     ],
                  //   );
                  // }),
                  const SizedBox(height: 20),
                  // if (!isSearching && searchQuery.isEmpty)
                  //   Obx(() {
                  //     if (controller.isLoading.value) {
                  //       return const Center(child: AppLoader());
                  //     }
                  //
                  //     if (recentController.recentSearches.isEmpty) {
                  //       return Center(
                  //           child: Text("No recent searches available".tr));
                  //     }
                  //
                  //     return RecentSearchSection(
                  //       recentSearches: recentController.recentSearches,
                  //       onTap: (search ) {
                  //         setState(() {
                  //           searchQuery = search;
                  //           searchController =
                  //               TextEditingController(text: search);
                  //           showResults = true;
                  //           controller.searchProducts(
                  //               searchQuery); // 🔄 Trigger search
                  //         });
                  //       },
                  //     );
                  //   }),
                ],
              ),
            ),
            if (showResults)
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return ProductShimmer();
                  }
                  if (controller.searchResults.isEmpty) {
                    return Container();
                  }

                  return SearchedProductsSection(
                    products: controller.searchResults,
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}
