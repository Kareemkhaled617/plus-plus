import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import '../../utils/validators.dart';

class OtpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter the OTP sent to your mobile".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Enter OTP".tr,
                controller: _otpController,
                keyboardType: TextInputType.number,
                validator: Validators.validateOtp,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Submit".tr,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Proceed with verification
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
