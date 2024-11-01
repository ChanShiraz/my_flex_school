import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/organizations/models/org_assoc_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrgSaveController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final FavController favController = Get.put(FavController());
  Future<bool> checkSave(int orgid) async {
    try {
      final data = await supabase
          .from('org_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!)
          .eq('orgid', orgid);
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

  Future<void> save(int orgid) async {
    try {
      OrgAssoc assocModel =
          OrgAssoc(userid: userController.user.value!.userid!, orgid: orgid);
      await supabase.from('org_assoc').insert(assocModel.toMap());
      favController.getFavOrganizations();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSave(int orgid, int index) async {
    try {
      await supabase
          .from('org_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('orgid', orgid);
      //favController.getFavOrganizations();
      favController.favOrganizations.removeAt(index);
      favController.favOrganizations.refresh();
    } catch (e) {
      print(e);
    } finally {}
  }
}
