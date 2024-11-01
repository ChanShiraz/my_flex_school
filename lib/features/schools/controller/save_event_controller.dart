import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/schools/model/event_assoc.dart';
import 'package:my_flex_school/features/schools/model/school_assoc_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaveEventController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final FavController favController = Get.put(FavController());

  Future<bool> checkSave(int eventId) async {
    try {
      final data = await supabase
          .from('event_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!)
          .eq('eventid', eventId);
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

  Future<void> saveEvent(int fsid) async {
    try {
      EventAssoc assocModel =
          EventAssoc(userid: userController.user.value!.userid!, eventid: fsid);
      await supabase.from('event_assoc').insert(assocModel.toMap());
      favController.getFavEvents();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSaveEvent(int eventId, int index) async {
    try {
      await supabase
          .from('event_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('eventid', eventId);
      favController.favEvents.removeAt(index);
      favController.favEvents.refresh();
      //favController.getFavEvents();
    } catch (e) {
      print(e);
    } finally {}
  }
}
