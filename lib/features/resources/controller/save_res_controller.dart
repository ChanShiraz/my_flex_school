import 'package:get/get.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/resources/models/res_assoc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaveResController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final FavController favController = Get.put(FavController());
  Future<bool> checkSave(int resId) async {
    try {
      final data = await supabase
          .from('res_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!)
          .eq('resid', resId);
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

  Future<void> save(int resid) async {
    try {
      ResAssoc assocModel =
          ResAssoc(userid: userController.user.value!.userid!, resid: resid);
      await supabase.from('res_assoc').insert(assocModel.toMap());
      favController.getFavResources();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSave(int resId,int index) async {
    try {
      await supabase
          .from('res_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('resid', resId);
          favController.favResources.removeAt(index);
          favController.favResources.refresh();
      //favController.getFavResources();
    } catch (e) {
      print(e);
    } finally {}
  }
}
