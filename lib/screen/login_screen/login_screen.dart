import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import '../../controller/auth_controller.dart';
import '../../utils/validators.dart';


class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                hintText: "Enter your mobile number".tr,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhoneNumber,
              ),
              SizedBox(height: 20),
              Obx(() => CustomButton(
                text: "Send Code".tr,
                isEnabled: _authController.isButtonEnabled.value,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _authController.sendCode();
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
