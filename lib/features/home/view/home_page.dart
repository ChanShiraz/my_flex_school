import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/fav/view/fav_page.dart';
import 'package:my_flex_school/features/my_schools/controller/my_school_controller.dart';
import 'package:my_flex_school/features/notifications/controller/notification_controller.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/my_schools/view/my_school_page.dart';
import 'package:my_flex_school/features/notifications/view/notification_page.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/profile/view/profile_page.dart';
import 'package:my_flex_school/features/resources/controller/save_res_controller.dart';
import 'package:my_flex_school/features/schools/controller/save_event_controller.dart';
import 'package:my_flex_school/features/schools/controller/schools_controller.dart';
import 'package:my_flex_school/features/schools/view/search_schools_page.dart';
import 'package:my_flex_school/features/services/controller/save_serv_controller.dart';
import 'package:my_flex_school/features/spa/controller/spa_controller.dart';
import 'package:my_flex_school/features/videos/controller/video_save_controller.dart';
import 'package:my_flex_school/features/videos/controller/videos_controller.dart';
import 'package:my_flex_school/features/videos/view/videos_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    MySchoolPage(),
    const FavPage(),
    ProfilePage()
  ];
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: AppColors.mainColor,
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.school_outlined),
            title: const Text('My School'),
            activeColor: AppColors.mainColor,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            title: const Text('My Favorites'),
            activeColor: AppColors.mainColor,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            activeColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }
}

class FeaturesWidget extends StatefulWidget {
  const FeaturesWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconData,
      required this.onTap});
  final String title;
  final String subTitle;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  State<FeaturesWidget> createState() => _FeaturesWidgetState();
}

class _FeaturesWidgetState extends State<FeaturesWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.subTitle,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                widget.iconData,
                color: AppColors.greenColor,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  NotificationController notificationController =
      Get.put(NotificationController());
  late SpaController spaController;
  late UserController userController;
  @override
  void initState() {
    spaController = Get.put(SpaController());
    userController = Get.put(UserController());
    spaController.getSpa();
    userController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        actions: [
          controller.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                )
              : Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(const NotificationPage());
                        },
                        icon: Obx(
                          () => Badge(
                            isLabelVisible: notificationController
                                    .notificationsCount.value >
                                0,
                            label: Text(notificationController
                                .notificationsCount.value
                                .toString()),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        )),
                    IconButton(
                      onPressed: () {
                        Get.to(ProfilePage());
                      },
                      icon: Icon(
                        size: 25,
                        Icons.person_outline,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(child: Image.asset('assets/images/logo.png')),
            // Container(
            //   height: height * 0.1,
            //   decoration: BoxDecoration(
            //     color: AppColors.mainColor,
            //     borderRadius: const BorderRadius.only(
            //       bottomLeft: Radius.circular(10),
            //       bottomRight: Radius.circular(10),
            //     ),
            //   ),
            //   child: Center(
            //     child: Column(
            //       // mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const SizedBox(
            //           width: double.infinity,
            //         ),
            //         const Text(
            //           'MYFLEXSCHOOL',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Text(
            //               'REACH',
            //               style: TextStyle(
            //                   color: Colors.white, fontWeight: FontWeight.bold),
            //             ),
            //             Padding(
            //               padding:
            //                   EdgeInsets.symmetric(horizontal: width * 0.02),
            //               child: CircleAvatar(
            //                 radius: 5,
            //                 backgroundColor: AppColors.greenColor,
            //               ),
            //             ),
            //             const Text(
            //               'CONNECT',
            //               style: TextStyle(
            //                   color: Colors.white, fontWeight: FontWeight.bold),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 5),
            //               child: CircleAvatar(
            //                 radius: 5,
            //                 backgroundColor: AppColors.greenColor,
            //               ),
            //             ),
            //             const Text(
            //               'ENGAGE',
            //               style: TextStyle(
            //                   color: Colors.white, fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  FeaturesWidget(
                    onTap: () {
                      Get.to(SearchSchoolsPage(
                        selectedFeature: 'Flex Schools',
                      ));
                    },
                    title: 'FLEX SCHOOLS',
                    subTitle: 'Find Flex Schools',
                    iconData: Icons.school_outlined,
                  ),
                  FeaturesWidget(
                      onTap: () {
                        Get.to(SearchSchoolsPage(
                          selectedFeature: 'Resources',
                        ));
                      },
                      title: 'RESOURCES',
                      subTitle: 'Find Resources',
                      iconData: Icons.miscellaneous_services_outlined),
                  FeaturesWidget(
                      onTap: () {
                        Get.to(SearchSchoolsPage(
                          selectedFeature: 'Services',
                        ));
                      },
                      title: 'SERVICES',
                      subTitle: 'Find Services',
                      iconData: Icons.design_services_outlined),
                  FeaturesWidget(
                      onTap: () {
                        Get.to(SearchSchoolsPage(
                          selectedFeature: 'Organizations',
                        ));
                      },
                      title: 'ORGANIZATION',
                      subTitle: 'Find Organizations',
                      iconData: Icons.work_outline_outlined),
                  FeaturesWidget(
                      onTap: () {
                        Get.to(SearchSchoolsPage(
                          selectedFeature: 'Events',
                        ));
                      },
                      title: 'EVENTS',
                      subTitle: 'Find Events',
                      iconData: Icons.event_note_rounded),
                  FeaturesWidget(
                      onTap: () {
                        Get.to(
                            // SearchSchoolsPage(
                            //   selectedFeature: 'Events',
                            // ),
                            VideosPage());
                      },
                      title: 'PRACTICE WELLNESS',
                      subTitle: 'Find Wellness Videos',
                      iconData: Icons.video_collection_outlined),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
