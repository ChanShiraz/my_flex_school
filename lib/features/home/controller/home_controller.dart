import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/auth/view/login_page.dart';
import 'package:my_flex_school/main.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> signOut(BuildContext context) async {
    try {
      isLoading.value = true;
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    } finally {
      isLoading.value = false;
      Get.offAll(() => const LoginPage());
    }
  }
}
