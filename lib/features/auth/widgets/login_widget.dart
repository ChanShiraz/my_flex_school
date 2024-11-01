import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/controller/login_controller.dart';
import 'package:my_flex_school/features/auth/view/forget_page.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key, required this.width});
  final double width;
  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomTextfield(
              hintText: 'Email',
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              prefixIon: const Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),
              validator:
                  ValidationBuilder().required("Email is required").build(),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => CustomTextfield(
                prefixIon: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                hintText: 'Password',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.passwordController,
                obsecureText: controller.passwordVisible.value,
                validator: ValidationBuilder()
                    .required("Password is required")
                    .build(),
                suffix: IconButton(
                  onPressed: () {
                    controller.passwordVisible.value =
                        !controller.passwordVisible.value;
                  },
                  icon: Icon(
                    controller.passwordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.to(() => ForgetPage());
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.greenColor),
                  minimumSize: WidgetStatePropertyAll(
                    Size(width * 0.5, 45),
                  ),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        controller.login(
                          context,
                          email: controller.emailController.text,
                          password: controller.passwordController.text,
                        );
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
