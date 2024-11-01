import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/videos/controller/youth_leader_controller.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class YouthLeadershipPage extends StatefulWidget {
  const YouthLeadershipPage({super.key});

  @override
  State<YouthLeadershipPage> createState() => _YouthLeadershipPageState();
}

class _YouthLeadershipPageState extends State<YouthLeadershipPage> {
  final videoController = Get.put(YouthLeaderController());
  @override
  void initState() {
    if (videoController.youthLeadershipVideos.isEmpty) {
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
                itemCount: videoController.youthLeadershipVideos.length,
                itemBuilder: (context, index) => VideoWidget(
                    index: index,
                    video: videoController.youthLeadershipVideos[index]),
              ),
      ),
    );
  }
}
