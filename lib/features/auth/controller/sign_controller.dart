import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/auth/model/user.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
import 'package:my_flex_school/main.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignController extends GetxController {
  SignController({this.userModel});
  final UserModel? userModel;
  var passwordVisible = true.obs;
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserController userController = Get.put(UserController());

  Rx<File?> profileImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  SupabaseClient supabase = Supabase.instance.client;

  @override
  void onInit() {
    if (userModel != null) {
      firstController.text = userModel!.firstName;
      lastController.text = userModel!.lastName;
      aboutController.text = userModel!.about;
      addressController.text = userModel!.address;
      emailController.text = userModel!.email;
      passwordController.text = userModel!.password;
    }
    super.onInit();
  }

  Future<void> signup(
    BuildContext context, {
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

      if (res.user != null) {
        FocusScope.of(context).unfocus();
        context.showSnackBar("🎉 Registration successful!");
        await uploadUser(res.user!.id);
        Get.offAll(() => const Home());
        isLoading.value = false;
        emailController.clear();
        passwordController.clear();
        aboutController.clear();
        addressController.clear();
        firstController.clear();
        lastController.clear();
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

  // getUser() async {
  //   final user = await supabase.from('users').select();
  //   print(user);
  // }
  Future<String> uploadImage() async {
    final String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch}.png';
    final response = await supabase.storage
        .from('user_avatars')
        .upload(fileName, profileImage.value!);
    final String publicUrl =
        supabase.storage.from('user_avatars').getPublicUrl(fileName);
    return publicUrl;
  }

  uploadUser(String uid) async {
    try {
      String avatarLink = await uploadImage();
      UserModel userModel = UserModel(
          uid: uid,
          // userId: userId,
          firstName: firstController.text,
          lastName: lastController.text,
          email: emailController.text,
          password: passwordController.text,
          role: 1,
          avatar: avatarLink,
          about: aboutController.text,
          createdBy: 1,
          createdDate: DateTime.now(),
          active: true,
          address: addressController.text);
      try {
        await supabase.from('users').insert(userModel.toMap());
        print('user uploaded');
      } catch (e) {
        print('error while uploading user $e');
      }
    } catch (e) {
      print('error $e');
    }
  }

  updateUser() async {
    isLoading.value = true;
    try {
      String avatarLink;
      if (profileImage.value != null) {
        avatarLink = await uploadImage();
      } else {
        avatarLink = userModel!.avatar;
      }
      UserModel model = UserModel(
          uid: userModel!.uid,
          userid: userModel!.userid,
          firstName: firstController.text,
          lastName: lastController.text,
          email: userModel!.email,
          password: passwordController.text,
          role: 1,
          avatar: avatarLink,
          about: aboutController.text,
          createdBy: 1,
          createdDate: userModel!.createdDate,
          active: true,
          address: addressController.text);
      await supabase
          .from('users')
          .update(model.toMap())
          .eq('userid', model.userid!);
      if (userModel!.password != passwordController.text) {
        print('condition true');
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(password: passwordController.text),
        );
      }
    } catch (e) {
      print(e);
    }
    Get.back();
    userController.getUser();
    isLoading.value = false;
  }
}
