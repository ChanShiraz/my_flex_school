import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/main.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> forgetPassword(
    BuildContext context, {
    required String email,
  }) async {
    try {
      isLoading.value = true;
      await supabase.auth.resetPasswordForEmail(email,
          redirectTo: "com.example.my_flex_school://login-callback");
      isLoading.value = false;
      emailController.clear();
      context.showSnackBar("Password reset email sent");
      Get.back();
    } on AuthException catch (e) {
      isLoading.value = false;
      if (e.message.contains('user not found')) {
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
