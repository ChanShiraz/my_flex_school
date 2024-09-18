import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/controller/forget_contrroller.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class ForgetPage extends StatelessWidget {
  ForgetPage({super.key});
  final controller = Get.put(ForgetController());
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 150,
                        color: AppColors.white,
                      ),
                      Icon(
                        Icons.lock,
                        size: 40,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Trouble Logging in?',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "Enter your email and We'll send you \na link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: CustomTextfield(
                            hintText: 'Email',
                            controller: controller.emailController,
                            prefixIon: const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: ValidationBuilder()
                                .required("Email is required")
                                .email()
                                .build(),
                          ),
                        ),
                        Obx(
                          () => Center(
                            child: FilledButton(
                              style: ButtonStyle(
                                minimumSize: WidgetStatePropertyAll(
                                    Size(width * 0.5, 45)),
                              ),
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }
                                      controller.forgetPassword(
                                        context,
                                        email: controller.emailController.text,
                                      );
                                    },
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Reset Password',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
