import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/schools/model/org_type.dart';
import 'package:my_flex_school/features/schools/model/res_type.dart';
import 'package:my_flex_school/features/schools/model/serv_type.dart';
import 'package:my_flex_school/features/spa/model/spa.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SchoolSearchController extends GetxController {
  RxString selectedSpa = 'Select Service Area'.obs;
  final zipController = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;

  bool checkForValue() {
    if (selectedSpa.value.contains('Select Service Area') &&
        zipController.text.isEmpty) {
      return false;
    }
    return true;
  }

  //ResTypes
  List<ResType> resTypes = <ResType>[].obs;
  RxList<ResType> selectedResTypes = <ResType>[].obs;
  RxBool resTypeLoading = false.obs;

  getResTypes() async {
    resTypeLoading.value = true;
    try {
      final data = await supabase.from('res_types').select();
      resTypes = data.map((json) => ResType.fromMap(json)).toList();
      selectedResTypes.addAll(resTypes);
      print('res types $resTypes');
    } catch (e) {
      // Get.rawSnackbar(message: 'Error while fetching my schools $e');
      print(e);
    }
    resTypeLoading.value = false;
  }

  removeResType(ResType resType) {
    selectedResTypes.remove(resType);
    selectedResTypes.refresh();
  }

  addResType(ResType resType) {
    selectedResTypes.add(resType);
    selectedResTypes.refresh();
  }

  deselectResTypes() {
    if (selectedResTypes.isEmpty || selectedResTypes.length < resTypes.length) {
      selectedResTypes.clear();
      selectedResTypes.addAll(resTypes);
    } else if (selectedResTypes.isNotEmpty) {
      selectedResTypes.clear();
    }
    selectedResTypes.refresh();
  }

  //OrgTypes
  List<OrgType> orgTypes = <OrgType>[].obs;
  RxList<OrgType> selectedOrgTypes = <OrgType>[].obs;
  RxBool orgTypeLoading = false.obs;

  getOrgTypes() async {
    orgTypeLoading.value = true;
    try {
      final data = await supabase.from('org_types').select();
      orgTypes = data.map((json) => OrgType.fromMap(json)).toList();
      selectedOrgTypes.addAll(orgTypes);
      print('res types $resTypes');
    } catch (e) {
      // Get.rawSnackbar(message: 'Error while fetching my schools $e');
      print(e);
    }
    orgTypeLoading.value = false;
  }

  removeOrgType(OrgType orgType) {
    selectedOrgTypes.remove(orgType);
    selectedOrgTypes.refresh();
  }

  addOrgType(OrgType orgType) {
    selectedOrgTypes.add(orgType);
    selectedOrgTypes.refresh();
  }

  deselectOrgTypes() {
    if (selectedOrgTypes.isEmpty || selectedOrgTypes.length < orgTypes.length) {
      selectedOrgTypes.clear();
      selectedOrgTypes.addAll(orgTypes);
    } else if (selectedOrgTypes.isNotEmpty) {
      selectedOrgTypes.clear();
    }
    selectedOrgTypes.refresh();
  }

  //ServTypes
  List<ServType> servTypes = <ServType>[].obs;
  RxList<ServType> selectedServTypes = <ServType>[].obs;
  RxBool servTypeLoading = false.obs;

  getServTypes() async {
    servTypeLoading.value = true;
    try {
      final data = await supabase.from('serv_types').select();
      servTypes = data.map((json) => ServType.fromMap(json)).toList();
      selectedServTypes.addAll(servTypes);
    } catch (e) {
      // Get.rawSnackbar(message: 'Error while fetching my schools $e');
      print(e);
    }
    servTypeLoading.value = false;
  }

  removeServType(ServType servType) {
    selectedServTypes.remove(servType);
    selectedServTypes.refresh();
  }

  addServType(ServType servType) {
    selectedServTypes.add(servType);
    selectedServTypes.refresh();
  }

  deselectServTypes() {
    if (selectedServTypes.isEmpty ||
        selectedServTypes.length < servTypes.length) {
      selectedServTypes.clear();
      selectedServTypes.addAll(servTypes);
    } else if (selectedServTypes.isNotEmpty) {
      selectedServTypes.clear();
    }
    selectedServTypes.refresh();
  }
}
