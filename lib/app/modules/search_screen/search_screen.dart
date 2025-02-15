import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/search_screen/widgets/recent_search_section.dart';
import 'package:plus/app/modules/search_screen/widgets/search_and_suggestion_section.dart';
import 'package:plus/app/modules/search_screen/widgets/searched_products_section.dart';

import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';


class SearchScreen extends StatefulWidget {
  static List<String> suggestions = [
    "Panadol",
    "Dolipran",
    "Paracetamol",
    "Ibuprofen",
    "Dolo-650",
    "Aspirin",
    "Dolorol"
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppKeys.howCanHelpYou.tr,
          style: AppFonts.heading3.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Hide keyboard when tapping outside
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Search Bar & Suggestions
              Column(
                children: [
                  SearchAndSuggestionSection(
                    controller: searchController,
                    // Use controller
                    suggestions: SearchScreen.suggestions,
                    searchQuery: searchQuery,
                    onHintSelected: (selected) {
                      setState(() {
                        searchQuery = selected;
                        searchController.text = selected; // Update text field
                        showResults = true;
                        isSearching = false;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        isSearching = value.isNotEmpty;
                        showResults = false; // Hide results while typing
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Show recent searches when not typing & search field empty
                  if (!isSearching && searchQuery.isEmpty)
                    RecentSearchSection(
                      recentSearches: SearchScreen.suggestions,
                      onTap: (search) {
                        log("Tapped: $search");
                        setState(() {
                          searchQuery = search;
                          searchController.text = search;
                          showResults = true;
                        });
                      },
                    ),
                ],
              ),

              if (showResults)
                Expanded(
                  child: SearchedProductsSection(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
