import 'package:flutter/material.dart';

void showCustomBottomSheet(context, Widget content) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: content,
          ),
        ],
      ),
    ),
  );
}
