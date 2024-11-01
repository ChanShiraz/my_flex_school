import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/videos/controller/sud_controller.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class SubstanceUseDisorder extends StatefulWidget {
  const SubstanceUseDisorder({super.key});
  @override
  State<SubstanceUseDisorder> createState() => _SubstanceUseDisorderState();
}

class _SubstanceUseDisorderState extends State<SubstanceUseDisorder> {
  final videoController = Get.put(SudController());
  @override
  void initState() {
    if (videoController.sudVideos.isEmpty) {
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
                itemCount: videoController.sudVideos.length,
                itemBuilder: (context, index) =>
                    VideoWidget(video: videoController.sudVideos[index],index: index,),
              ),
      ),
    );
  }
}
