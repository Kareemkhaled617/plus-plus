import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controller/auth_controller.dart';

class PhoneInputWidget extends StatelessWidget {
  final AuthController authController;

  const PhoneInputWidget({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: IntlPhoneField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.shade50.withOpacity(.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        initialCountryCode: 'EG',
        onChanged: (phone) {
          print(phone.completeNumber);
          authController.phoneController.text =
              phone.completeNumber.replaceFirst("+", "");
          authController.validatePhoneNumber(phone.completeNumber);
        },
      ),
    );
  }
}
