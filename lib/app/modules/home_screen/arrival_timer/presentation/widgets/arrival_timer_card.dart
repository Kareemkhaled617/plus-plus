import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';
import '../controller/arrival_timer_controller.dart';

class ArrivalTimerCard extends StatelessWidget {
  final ArrivalTimerController controller = Get.put(ArrivalTimerController());

  ArrivalTimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalDuration = const Duration(minutes: 60);
      final remaining = controller.remaining;
      final progress = 1.0 - (remaining.inSeconds / totalDuration.inSeconds);
      final minutes = remaining.inMinutes;
      final seconds = remaining.inSeconds % 60;
      final remainingTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      return Container(
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
            // Left side: logo and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesLogo),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estimated arrival'.tr,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff2B2929))),
                    const SizedBox(height: 4),
                    Text('$remainingTime ${'minutes'.tr}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),

            // Right side: Circular Progress + image + time
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.indigo.shade800),
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Assets.iconsTimer,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
