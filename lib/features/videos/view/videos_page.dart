import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/videos/controller/videos_controller.dart';
import 'package:my_flex_school/features/videos/view/sud_videos_page.dart';
import 'package:my_flex_school/features/videos/view/youth_empowerment_page.dart';
import 'package:my_flex_school/features/videos/view/welness_video_page.dart';
import 'package:my_flex_school/features/videos/view/youth_leadership_page.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class VideosPage extends StatelessWidget {
  TabBar get _tabBar => const TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            text: 'Wellness',
          ),
          Tab(
            text: 'Substance Use Disorder',
          ),
          Tab(
            text: 'Youth Leadership',
          ),
          Tab(
            text: 'Youth Empowerment',
          ),
        ],
      );
  VideosPage({super.key});
  final VideosController controller = Get.put(VideosController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    controller.getVideos();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Personal Growth Videos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColors.mainColor,
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.white,
              child: _tabBar,
            ),
          ),
        ),
        body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TabBarView(children: [
              WelnessVideoPage(),
              SubstanceUseDisorder(),
              YouthLeadershipPage(),
              YouthEmpowermentPage()
            ])),
      ),
    );
  }
}


// Obx(
//             () => controller.loadingVideos.value
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : GridView.builder(
//                     itemCount: controller.videos.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisExtent: height * 0.15,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         crossAxisCount: 2),
//                     itemBuilder: (context, index) {
//                       return VideoWidget(
//                         video: controller.videos[index],
//                       );
//                     },
//                   ),
//           ),