import 'package:get/get.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/resources/models/res_assoc.dart';
import 'package:my_flex_school/features/services/model/serv_assoc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaveServController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final FavController favController = Get.put(FavController());

  Future<bool> checkSave(int resId) async {
    try {
      final data = await supabase
          .from('serv_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!)
          .eq('servid', resId);
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

  Future<void> save(int servid) async {
    try {
      ServAssoc assocModel =
          ServAssoc(userid: userController.user.value!.userid!, servid: servid);
      await supabase.from('serv_assoc').insert(assocModel.toMap());
      favController.getFavServices();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSave(int resId, int index) async {
    try {
      await supabase
          .from('serv_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('servid', resId);
      favController.favServices.removeAt(index);
      favController.favServices.refresh();
      //favController.getFavServices();
    } catch (e) {
      print(e);
    } finally {}
  }
}
