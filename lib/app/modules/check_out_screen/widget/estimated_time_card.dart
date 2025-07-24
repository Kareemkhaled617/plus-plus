import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimatedTimeCard extends StatelessWidget {
  final int minutes;

  const EstimatedTimeCard({super.key, this.minutes = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCECEC), // Background light red/pink
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.flash_on_outlined, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Estimated Time'.tr,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Delivery  Within $minutes Min',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
