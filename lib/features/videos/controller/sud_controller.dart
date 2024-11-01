import 'package:get/get.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SudController extends GetxController {
  RxBool loadingVideos = false.obs;
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<Video> sudVideos = <Video>[].obs;
  getVideos() async {
    loadingVideos.value = true;
    try {
      sudVideos.clear();
      final List<dynamic> data =
          await supabase.from('wellness_vids').select().eq('type', 2);
      final List<Video> videoData =
          data.map((json) => Video.fromMap(json)).toList();
      sudVideos.addAll(videoData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error while loading videos $e');
    }
    loadingVideos.value = false;
  }
}
