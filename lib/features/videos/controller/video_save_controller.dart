import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/organizations/models/org_assoc_model.dart';
import 'package:my_flex_school/features/videos/model/video_assoc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VideoSaveController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final FavController favController = Get.put(FavController());
  Future<bool> checkSave(int wellVidId) async {
    try {
      final data = await supabase
          .from('vids_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!)
          .eq('well_vid_id', wellVidId);
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error $e');
      return false;
    }
  }

  Future<void> save(int wellVidId) async {
    try {
      VideoAssoc assocModel = VideoAssoc(
          userid: userController.user.value!.userid!, well_vid_id: wellVidId);
      await supabase.from('vids_assoc').insert(assocModel.toMap());
      favController.getFavVideos();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSave(int wellVidId, int index) async {
    try {
      await supabase
          .from('vids_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('well_vid_id', wellVidId);
      favController.favVideos.removeAt(index);
      favController.favVideos.refresh();
    } catch (e) {
      print(e);
    } finally {}
  }
}
