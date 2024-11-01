import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/spa/model/spa.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpaController extends GetxController {
  RxList<ServicePlanningArea> spa = <ServicePlanningArea>[].obs;
  RxBool isLoadingSpa = false.obs;
  final SupabaseClient supabase = Supabase.instance.client;

  getSpa() async {
    isLoadingSpa.value = true;
    try {
      spa.clear();
      final List<dynamic> data =
          await supabase.from('service_planning_areas').select();
      final List<ServicePlanningArea> spaData =
          data.map((json) => ServicePlanningArea.fromMap(json)).toList();

      spa.addAll(spaData);
      spa.refresh();
    } catch (e) {
      Get.rawSnackbar(
          message: 'Error While Fetching Service Planning Areas $e');
    }
    isLoadingSpa.value = false;
  }
}
