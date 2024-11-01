import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/videos/controller/wellness_video_controller.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class WelnessVideoPage extends StatefulWidget {
  const WelnessVideoPage({super.key});

  @override
  State<WelnessVideoPage> createState() => _WelnessVideoPageState();
}

class _WelnessVideoPageState extends State<WelnessVideoPage> {
  final WellnessVideoController videoController =
      Get.put(WellnessVideoController());

  @override
  void initState() {
    if (videoController.wellnessVideos.isEmpty) {
      videoController.getVideos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => videoController.loadingVideos.value
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: videoController.wellnessVideos.length,
                itemBuilder: (context, index) =>
                    VideoWidget(video: videoController.wellnessVideos[index],index: index,),
              ),
      ),
    );
  }
}
