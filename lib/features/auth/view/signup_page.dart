import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/model/user.dart';
import 'package:my_flex_school/features/auth/widgets/signup_widget.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png'),
                        Text(
                          userModel == null ? 'Sign Up' : 'Update Profile',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SignupWidget(
                          width: width,
                          userModel: userModel,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              userModel == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already  have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  : const SizedBox(
                      height: 20,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
