import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/features/videos/controller/youth_empowerment_controller.dart';
import 'package:my_flex_school/features/videos/widgets/video_widget.dart';

class YouthEmpowermentPage extends StatefulWidget {
  const YouthEmpowermentPage({super.key});

  @override
  State<YouthEmpowermentPage> createState() => _YouthEmpowermentPageState();
}

class _YouthEmpowermentPageState extends State<YouthEmpowermentPage> {
  final videoController = Get.put(YouthEmpowermentController());
  @override
  void initState() {
    if (videoController.youthEmpowermentVideos.isEmpty) {
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
                itemCount: videoController.youthEmpowermentVideos.length,
                itemBuilder: (context, index) => VideoWidget(index: index,
                    video: videoController.youthEmpowermentVideos[index]),
              ),
      ),
    );
  }
}
