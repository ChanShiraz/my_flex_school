import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
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
      final AuthResponse res = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      isLoading.value = false;
      if (res.user != null) {
        Get.offAll(const HomePage());
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      if (e.message.contains('invalid login credentials')) {
        _showErrorMessage(
            context, 'Incorrect email or password. Please try again.');
      } else if (e.message.contains('user not found')) {
        _showErrorMessage(
            context, 'No account found with this email. Please sign up.');
      } else if (e.message.contains('network error')) {
        _showErrorMessage(
            context, 'Network error. Please check your internet connection.');
      } else {
        _showErrorMessage(context, 'Login failed: ${e.message}');
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
