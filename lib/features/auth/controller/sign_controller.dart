import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignController extends GetxController {
  var passwordVisible = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> signup(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await Supabase.instance.client.auth
          .signUp(email: email, password: password);
      isLoading.value = false;
      if (res.user != null) {
        Get.offAll(const HomePage());
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      if (e.message.contains('invalid email')) {
        _showErrorMessage(context, 'Please enter a valid email address.');
      } else if (e.message.contains('weak password')) {
        _showErrorMessage(context, 'Password is too weak. Try a stronger one.');
      } else if (e.message.contains('email already exists')) {
        _showErrorMessage(
            context, 'This email is already registered. Please log in.');
      } else if (e.message.contains('network error')) {
        _showErrorMessage(
            context, 'Network error. Please check your internet connection.');
      } else {
        _showErrorMessage(context, 'Sign-up failed: ${e.message}');
      }
    } catch (e) {
      isLoading.value = false;
      log("message : $e");
      _showErrorMessage(
          context, 'An unexpected error occurred. Please try again.');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}
