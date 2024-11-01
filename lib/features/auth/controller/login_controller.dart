import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
import 'package:my_flex_school/main.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  var passwordVisible = true.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      isLoading.value = false;
      if (res.user != null) {
        emailController.clear();
        passwordController.clear();
        Get.offAll(() => Home());
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      if (e.message.contains('invalid login credentials')) {
        context.showSnackBar('Incorrect email or password. Please try again.',
            isError: true);
      } else if (e.message.contains('user not found')) {
        context.showSnackBar(
            'No account found with this email. Please sign up.',
            isError: true);
      } else if (e.message.contains('network error')) {
        context.showSnackBar(
            'Network error. Please check your internet connection.',
            isError: true);
      } else {
        context.showSnackBar('Login failed: ${e.message}', isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      log("message : $e");
      context.showSnackBar('An unexpected error occurred. Please try again.',
          isError: true);
    }
  }
}
