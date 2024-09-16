import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var passwordVisible = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  setEmail() {
    email.value = emailController.text;
  }

  setPassword() {
    password.value = passwordController.text;
  }
}
