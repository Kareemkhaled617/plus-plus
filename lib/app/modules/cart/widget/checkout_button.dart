import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../controller/cart_controller.dart';

class CheckoutButton extends StatelessWidget {
  final String total;
  final VoidCallback onPressed;

  const CheckoutButton({
    super.key,
    required this.total,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C3190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              AppKeys.checkout.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Text(
              total,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
