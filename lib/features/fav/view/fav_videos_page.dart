import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/organizations/widgets/org_details_widget.dart';
import 'package:my_flex_school/features/organizations/widgets/org_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resources_widget.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class FavVideosPage extends StatefulWidget {
  const FavVideosPage({super.key});

  @override
  State<FavVideosPage> createState() => _FavVideosPageState();
}

class _FavVideosPageState extends State<FavVideosPage> {
  final FavController favController = Get.put(FavController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favController.favVideos.isEmpty) {
        favController.getFavVideos();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => favController.loadingVideos.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favController.favVideos.length,
                itemBuilder: (context, index) {
                  return VideoWidget(
                    video: favController.favVideos[index],
                    index: index,
                  );
                },
              ),
      ),
    );
  }
}
