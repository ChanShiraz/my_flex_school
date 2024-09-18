import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:my_flex_school/features/auth/controller/sign_controller.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class SignupWidget extends StatelessWidget {
  SignupWidget({super.key, required this.width, required this.tabController});
  final double width;
  final TabController tabController;
  final controller = Get.put(SignController());
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
              prefixIon: const Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ValidationBuilder()
                  .required("Email is required")
                  .email()
                  .build(),
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
                controller: controller.passwordController,
                hintText: 'Password',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                obsecureText: controller.passwordVisible.value,
                validator: ValidationBuilder()
                    .required("Password is required")
                    .minLength(8)
                    .maxLength(24)
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
            const SizedBox(height: 20),
            Obx(
              () => FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(width * 0.5, 45)),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        controller.signup(
                          context,
                          tabController,
                          email: controller.emailController.text,
                          password: controller.passwordController.text,
                        );
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Sign Up',
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
