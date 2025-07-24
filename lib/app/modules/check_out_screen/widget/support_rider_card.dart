import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportRiderCard extends StatefulWidget {
  const SupportRiderCard({super.key});

  @override
  State<SupportRiderCard> createState() => _SupportRiderCardState();
}

class _SupportRiderCardState extends State<SupportRiderCard> {
  int? selectedAmount = 15;

  final List<int> amounts = [15, 10, 20];

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCECEC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EL LEWAA STORE Rider',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
           Text(
            '100% Of This Trip Will Go To The Associated Rider'.tr,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: amounts.map((amount) {
              final isSelected = selectedAmount == amount;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedAmount = amount;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.indigo : Colors.transparent,
                    side: BorderSide(
                      color: isSelected ? Colors.indigo : Colors.grey,
                    ),
                    foregroundColor: isSelected ? Colors.white : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text('$amount L.E'),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
