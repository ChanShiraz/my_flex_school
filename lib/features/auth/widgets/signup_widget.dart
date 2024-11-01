import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/controller/sign_controller.dart';
import 'package:my_flex_school/features/auth/model/user.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key, required this.width, this.userModel});
  final double width;
  final UserModel? userModel;

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late SignController controller;

  @override
  void initState() {
    controller = Get.put(SignController(userModel: widget.userModel));
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: () async {
                  try {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      controller.profileImage.value = File(image.path);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Obx(
                  () => CircleAvatar(
                    radius: 70,
                    backgroundImage: controller.profileImage.value != null
                        ? FileImage(controller.profileImage.value!)
                        : widget.userModel != null
                            ? CachedNetworkImageProvider(
                                widget.userModel!.avatar)
                            : null,
                    child: controller.profileImage.value == null &&
                            widget.userModel == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextfield(
                controller: controller.firstController,
                prefixIon: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                hintText: 'First name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter first name';
                  }
                  return null;
                },
              ),
            ),
            CustomTextfield(
              controller: controller.lastController,
              prefixIon: const Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              hintText: 'Last name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter last name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
                controller: controller.aboutController,
                maxLines: 3,
                borderRadius: 20,
                prefixIon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.grey,
                ),
                hintText: 'About'),
            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
              controller: controller.addressController,
              prefixIon: const Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
              ),
              hintText: 'City',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter City';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            widget.userModel == null
                ? Column(
                    children: [
                      CustomTextfield(
                        readOnly: widget.userModel != null ? true : false,
                        hintText: 'Email',
                        controller: controller.emailController,
                        prefixIon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox(),
            Obx(
              () => CustomTextfield(
                prefixIon: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                controller: controller.passwordController,
                hintText: 'Password',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                obsecureText: controller.passwordVisible.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
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
            const SizedBox(height: 20),
            Obx(
              () => FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.greenColor),
                  minimumSize:
                      WidgetStatePropertyAll(Size(widget.width * 0.5, 45)),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        if (controller.profileImage.value == null &&
                            widget.userModel == null) {
                          Get.rawSnackbar(
                              message: 'Please select the profile image');
                          return;
                        }
                        if (widget.userModel == null) {
                          controller.signup(
                            context,
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                        } else {
                          controller.updateUser();
                        }
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text(
                        widget.userModel == null ? 'Sign Up' : 'Update Profile',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
