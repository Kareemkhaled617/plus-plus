import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/prescription_entity.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionEntity prescription;

  const PrescriptionCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.d()
                          .format(DateTime.parse(prescription.createdAt)),
                      style: AppFonts.heading2
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                    Text(
                      DateFormat.MMM()
                          .format(DateTime.parse(prescription.createdAt))
                          .toUpperCase(),
                      style: AppFonts.heading2
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prescription.orderProductNames, // Dynamically show name
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.heading3
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppKeys.prescription.tr,
                      style: AppFonts.bodyText
                          .copyWith(fontSize: 12, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),

              /// **Status Section**
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      prescription.status,
                      style: AppFonts.bodyText.copyWith(
                          fontSize: 14,
                          color: AppColors.red,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),

          /// **View Button**
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  showPrescriptionsBottomSheet(context, prescription);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(80, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppKeys.view.tr,
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }



  void showPrescriptionsBottomSheet(
      BuildContext context,
      PrescriptionEntity prescription, {
        VoidCallback? onView,        // open full screen viewer / PDF
        VoidCallback? onReorder,     // trigger reorder flow
        VoidCallback? onDelete,      // optional delete
      }) {
    final isPdf = prescription.imageType.toLowerCase() == 'pdf';
    final status = prescription.status.toLowerCase();

    Color statusColor() {
      if (status.contains('pending')) return const Color(0xFFF59E0B); // amber
      if (status.contains('rejected') || status.contains('cancel')) {
        return const Color(0xFFEF4444); // red
      }
      return const Color(0xFF10B981); // green
    }

    String statusLabel() {
      return prescription.status; // already localized by your layer if needed
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          minChildSize: 0.45,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.10),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // drag handle
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Header with soft gradient
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [const Color(0xFFF9FAFB), Colors.grey.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        // preview
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: isPdf
                              ? Container(
                            width: 72,
                            height: 72,
                            color: Colors.red.withOpacity(.08),
                            alignment: Alignment.center,
                            child: const Icon(Icons.picture_as_pdf,
                                color: Colors.red, size: 38),
                          )
                              : CachedNetworkImage(
                            imageUrl: prescription.image,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => Container(
                              width: 72,
                              height: 72,
                              color: Colors.grey.shade200,
                            ),
                            errorWidget: (_, __, ___) => Container(
                              width: 72,
                              height: 72,
                              color: Colors.grey.shade200,
                              alignment: Alignment.center,
                              child: const Icon(Icons.broken_image_outlined,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // title + status chip
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prescription.aboutImage,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor().withOpacity(.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  statusLabel(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Scroll content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16)
                          .copyWith(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          _InfoRow(
                            icon: Icons.list_alt_outlined,
                            label: 'Items',
                            value: prescription.orderProductNames,
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            icon: Icons.schedule_outlined,
                            label: 'Created at',
                            value: prescription.createdAt,
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            icon: Icons.description_outlined,
                            label: 'Type',
                            value: isPdf ? 'PDF' : 'Image',
                          ),

                          // Optional long preview area (tap to view)
                          if (!isPdf) ...[
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: onView,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: prescription.image,
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: double.infinity,
                                  placeholder: (context, _) => Container(
                                    height: 180,
                                    color: Colors.grey.shade200,
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    height: 180,
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // sticky actions
                  // SafeArea(
                  //   top: false,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: OutlinedButton.icon(
                  //             onPressed: onReorder,
                  //             style: OutlinedButton.styleFrom(
                  //               padding: const EdgeInsets.symmetric(vertical: 14),
                  //               side: BorderSide(color: Colors.indigo.shade700),
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(12)),
                  //             ),
                  //             icon: Icon(Icons.shopping_bag_outlined,
                  //                 color: Colors.indigo.shade700),
                  //             label: Text(
                  //               'Re‑order',
                  //               style: TextStyle(
                  //                   color: Colors.indigo.shade700,
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(width: 12),
                  //         Expanded(
                  //           child: ElevatedButton.icon(
                  //             onPressed: onView,
                  //             style: ElevatedButton.styleFrom(
                  //               backgroundColor: const Color(0xFF27328C),
                  //               padding: const EdgeInsets.symmetric(vertical: 14),
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(12)),
                  //               elevation: 0,
                  //             ),
                  //             icon: const Icon(Icons.visibility_outlined,
                  //                 color: Colors.white),
                  //             label: const Text(
                  //               'View',
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //           ),
                  //         ),
                  //         if (onDelete != null) ...[
                  //           const SizedBox(width: 12),
                  //           IconButton(
                  //             onPressed: onDelete,
                  //             style: IconButton.styleFrom(
                  //               backgroundColor: Colors.red.withOpacity(.08),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(12),
                  //               ),
                  //             ),
                  //             icon: const Icon(Icons.delete_outline,
                  //                 color: Colors.red),
                  //           ),
                  //         ],
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }



}
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}