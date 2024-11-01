import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VideosController extends GetxController {
  RxBool loadingVideos = false.obs;
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<Video> videos = <Video>[].obs;
  getVideos() async {
    loadingVideos.value = true;
    try {
      videos.clear();
      final List<dynamic> data =
          await supabase.from('wellness_vids').select().order('well_vid_id');
      final List<Video> videoData =
          data.map((json) => Video.fromMap(json)).toList();
      videos.addAll(videoData);
    } catch (e) {
      print(e);
      Get.rawSnackbar(message: 'Error while loading videos $e');
    }
    loadingVideos.value = false;
  }
}
