import 'package:get/get.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/model/school_assoc_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MySchoolController extends GetxController {
  UserController userController = Get.put(UserController());
  SupabaseClient supabase = Supabase.instance.client;
  RxList<School> mySchools = <School>[].obs;
  RxBool loading = false.obs;

  Future<void> getMySchools() async {
    mySchools.clear();
    loading.value = true;
    try {
      final data = await supabase
          .from('flex_school_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<SchoolAssocModel> schoolAssociation =
          data.map((json) => SchoolAssocModel.fromMap(json)).toList();
      for (var element in schoolAssociation) {
        final school = await supabase
            .from('flexschools')
            .select()
            .eq('fsid', element.fsid);
        List<School> mySchool =
            school.map((json) => School.fromMap(json)).toList();
        mySchools.addAll(mySchool);
      }
    } catch (e) {
      // Get.rawSnackbar(message: 'Error while fetching my schools $e');
      print(e);
    }
    loading.value = false;
  }
}
