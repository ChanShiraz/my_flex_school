import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/fav/view/fav_event_page.dart';
import 'package:my_flex_school/features/fav/view/fav_organizations_page.dart';
import 'package:my_flex_school/features/fav/view/fav_resources_page.dart';
import 'package:my_flex_school/features/fav/view/fav_services_page.dart';
import 'package:my_flex_school/features/fav/view/fav_videos_page.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  TabBar get _tabBar => const TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            text: 'EVENTS',
          ),
          Tab(
            text: 'SERVICES',
          ),
          Tab(
            text: 'RESOURCES',
          ),
          Tab(
            text: 'ORGANIZATIONS',
          ),
          Tab(
            text: 'VIDEOS',
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'My Favorites',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
          body: const TabBarView(children: [
            FavEventPage(),
            FavServicesPage(),
            FavResourcesPage(),
            FavOrganizationsPage(),
            FavVideosPage()
          ])),
    );
  }
}
