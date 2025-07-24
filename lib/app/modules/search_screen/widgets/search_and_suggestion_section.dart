import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class SearchAndSuggestionSection extends StatefulWidget {
  const SearchAndSuggestionSection({
    super.key,
    required this.controller, // Pass the controller
    required this.suggestions,
    required this.searchQuery,
    this.onChanged,
    this.onHintSelected,
  });

  final TextEditingController controller;
  final List<String> suggestions;
  final String searchQuery;
  final Function(String)? onChanged;
  final Function(String)? onHintSelected;

  @override
  State<SearchAndSuggestionSection> createState() =>
      _SearchAndSuggestionSectionState();
}

class _SearchAndSuggestionSectionState
    extends State<SearchAndSuggestionSection> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(text: widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return widget.suggestions.where(
          (option) => option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()),
        );
      },
      onSelected: (String selection) {
        log("Selected: $selection");
        widget.controller.text = selection;
        _internalController.text = selection;
        widget.onHintSelected?.call(selection);
      },
      fieldViewBuilder: (
        context,
        textFieldController,
        focusNode,
        onFieldSubmitted,
      ) {
        if (textFieldController.text.isEmpty) {
          textFieldController.text = _internalController.text;
        }

        return CustomTextFormField(
          controller: textFieldController,
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFieldSubmitted(),
          onChanged: (value) {
            _internalController.text = value;
            widget.onChanged?.call(value);
          },
          hintText: AppKeys.search.tr,
          hintStyle: TextStyle(color: Colors.black54),
          keyboardType: TextInputType.text,
          fillColor: Colors.white,
          prefixIcon: Image.asset(Assets.iconsSearch),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(option, style: TextStyle(fontSize: 16)),
                    leading: Icon(Icons.search_rounded, size: 32),
                    onTap: () {
                      onSelected(option);
                      _internalController.text = option;
                      widget.controller.text = option;
                      widget.onHintSelected?.call(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }
}
