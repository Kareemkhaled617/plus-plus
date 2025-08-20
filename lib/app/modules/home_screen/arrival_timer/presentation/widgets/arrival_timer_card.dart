// lib/app/modules/home_screen/arrival_timer/presentation/widgets/arrival_timer_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../generated/assets.dart';

import '../../../../../routes/app_routes.dart';
import '../controller/order_countdown_controller.dart';

class ArrivalTimerCard extends StatelessWidget {
  final OrderCountdownController c;

  ArrivalTimerCard({super.key, required List orders})
      : c = Get.put(OrderCountdownController(orders.cast()), permanent: true);

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    // label says "minutes", but we show mm:ss for clarity (keep your translation key if needed)
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final rem = c.remaining.value;
      final total = c.totalSeconds.value;
      final progress = total == 0 ? 0.0 : 1.0 - (rem.inSeconds / total).clamp(0.0, 1.0);

      return InkWell(
          onTap: () {
            final orderId = c.currentOrderId;
            if (orderId != null) {
              Get.toNamed(
                AppRoutes.orderDetailsScreen,
                arguments: {"orderId": orderId},
              );
            }
          },

          child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage(Assets.imagesLogo)),
                    ),
                  ),
                  const SizedBox(height: 16),
                   Text(
                    'Estimated arrival'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2B2929)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_fmt(rem)} ${'minutes'.tr}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.currentOrderLabel,
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),

              // right
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80, height: 80,
                    child: CircularProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      strokeWidth: 3,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade800),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30, backgroundColor: Colors.white,
                    child: Image.asset(Assets.iconsTimer, width: 50, height: 50, fit: BoxFit.cover),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
