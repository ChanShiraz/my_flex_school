import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/view/signup_page.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/profile/widgets/detail_tile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(
          () {
            return Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: ArcClipper(),
                      child: Container(
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.mainColor,
                              AppColors.mainColor.withOpacity(0.5)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.13,
                      left: width / 2 - 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                          userController.user.value!.avatar,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                userController.loadingUser.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        children: [
                          DetailTile(
                              title:
                                  '${userController.user.value!.firstName} ${userController.user.value!.lastName}',
                              iconData: Icons.person_outline),
                          DetailTile(
                              title: userController.user.value!.email,
                              iconData: Icons.email_outlined),
                          DetailTile(
                              title: userController.user.value!.address,
                              iconData: Icons.location_on_outlined),
                          DetailTile(
                              title: userController.user.value!.about,
                              iconData: Icons.info_outline_rounded),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Get.to(SignupPage(
                      userModel: userController.user.value,
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    userController.signOut(context);
                  },
                )
              ],
            );
          },
        ));
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
