import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/main.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignController extends GetxController {
  var passwordVisible = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> signup(
    BuildContext context,
    TabController tabController, {
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: "com.example.my_flex_school://login-callback",
      );
      isLoading.value = false;
      if (res.user != null) {
        FocusScope.of(context).unfocus();

        context.showSnackBar(
            "🎉 Registration successful! Please check your email to verify your account.");
        emailController.clear();
        passwordController.clear();
        tabController.animateTo(tabController.previousIndex);
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      if (e.message.contains('invalid email')) {
        context.showSnackBar('Please enter a valid email address.',
            isError: true);
      } else if (e.message.contains('weak password')) {
        context.showSnackBar('Password is too weak. Try a stronger one.',
            isError: true);
      } else if (e.message.contains('email already exists')) {
        context.showSnackBar('This email is already registered. Please log in.',
            isError: true);
      } else if (e.message.contains('network error')) {
        context.showSnackBar(
            'Network error. Please check your internet connection.',
            isError: true);
      } else {
        context.showSnackBar('Sign-up failed: ${e.message}');
      }
    } catch (e) {
      isLoading.value = false;
      log("message : $e");
      context.showSnackBar('An unexpected error occurred. Please try again.',
          isError: true);
    }
  }
}
