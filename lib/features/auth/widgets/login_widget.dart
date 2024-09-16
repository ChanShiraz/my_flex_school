import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/controller/login_controller.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key, required this.width});
  final double width;
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        const CustomTextfield(
          hintText: 'Email',
          prefixIon: Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
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
            keyboardType: TextInputType.visiblePassword,
            obsecureText: controller.passwordVisible.value,
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
            onPressed: () {},
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(width * 0.5, 40)),
              backgroundColor: WidgetStatePropertyAll(AppColors.mainColor)),
          onPressed: () {},
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
