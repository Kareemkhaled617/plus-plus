import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void showContactDialog(
    BuildContext context, String phoneNumber, String address) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title:  Text(
          "Contact Information".tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: Text(phoneNumber, style: const TextStyle(fontSize: 16)),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _launchPhone(phoneNumber),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.redAccent),
              title: Text(address, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat, color: Colors.white),
              label: Text(
                "Contact via WhatsApp".tr,
                style: AppFonts.bodyText.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _launchWhatsApp(phoneNumber),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.close),
              label: const Text("إغلاق"),
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.grey),
                minimumSize: const Size.fromHeight(45),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _launchPhone(String phoneNumber) async {
  final Uri phoneUri = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  }
}

void _launchWhatsApp(String phoneNumber) async {
  final Uri whatsappUri =
      Uri.parse("https://wa.me/$phoneNumber?text=مرحبا، أريد الاستفسار عن طلب");
  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  }
}
