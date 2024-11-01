import 'package:get/get.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class YouthEmpowermentController extends GetxController {
  RxBool loadingVideos = false.obs;
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<Video> youthEmpowermentVideos = <Video>[].obs;
  getVideos() async {
    loadingVideos.value = true;
    try {
      youthEmpowermentVideos.clear();
      final List<dynamic> data =
          await supabase.from('wellness_vids').select().eq('type', 4);
      final List<Video> videoData =
          data.map((json) => Video.fromMap(json)).toList();
      youthEmpowermentVideos.addAll(videoData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error while loading videos $e');
    }
    loadingVideos.value = false;
  }
}
