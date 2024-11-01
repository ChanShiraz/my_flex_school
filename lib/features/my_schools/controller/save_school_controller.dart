import 'package:get/get.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/my_schools/controller/my_school_controller.dart';
import 'package:my_flex_school/features/schools/model/school_assoc_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaveSchoolController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  UserController userController = Get.put(UserController());
  final MySchoolController schoolController = Get.put(MySchoolController());

  Future<bool> checkSave(int fsid) async {
    final data = await supabase
        .from('flex_school_assoc')
        .select()
        .eq('userid', userController.user.value!.userid!)
        .eq('fsid', fsid);
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveSchool(int fsid) async {
    try {
      SchoolAssocModel assocModel = SchoolAssocModel(
          userid: userController.user.value!.userid!, fsid: fsid);
      await supabase.from('flex_school_assoc').insert(assocModel.toMap());
      await schoolController.getMySchools();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> unSaveSchool(int fsid, int index) async {
    try {
      await supabase
          .from('flex_school_assoc')
          .delete()
          .eq('userid', userController.user.value!.userid!)
          .eq('fsid', fsid);
      //schoolController.getMySchools();
      schoolController.mySchools.removeAt(index);
      schoolController.mySchools.refresh();
    } catch (e) {
      print(e);
    } finally {}
  }
}
