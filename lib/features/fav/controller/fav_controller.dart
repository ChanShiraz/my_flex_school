import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/organizations/models/org_assoc_model.dart';
import 'package:my_flex_school/features/resources/models/res_assoc.dart';
import 'package:my_flex_school/features/schools/model/event_assoc.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/services/model/serv_assoc.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:my_flex_school/features/videos/model/video_assoc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavController extends GetxController {
  UserController userController = Get.put(UserController());
  SupabaseClient supabase = Supabase.instance.client;
  RxList<Event> favEvents = <Event>[].obs;
  RxList<ServiceModel> favServices = <ServiceModel>[].obs;
  RxList<Resource> favResources = <Resource>[].obs;
  RxList<Organization> favOrganizations = <Organization>[].obs;
  RxList<Video> favVideos = <Video>[].obs;
  RxBool loadingEvents = false.obs;
  RxBool loadingServices = false.obs;
  RxBool loadingResources = false.obs;
  RxBool loadingOrganizations = false.obs;
  RxBool loadingVideos = false.obs;

  getFavEvents() async {
    loadingEvents.value = true;
    try {
      favEvents.clear();
      final data = await supabase
          .from('event_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<EventAssoc> eventsAssociation =
          data.map((json) => EventAssoc.fromMap(json)).toList();
      for (var element in eventsAssociation) {
        final event = await supabase
            .from('events')
            .select()
            .eq('eventid', element.eventid);
        List<Event> myEvent = event.map((json) => Event.fromMap(json)).toList();
        favEvents.addAll(myEvent);
      }
    } catch (e) {
      print(e);
    }
    loadingEvents.value = false;
  }

  getFavServices() async {
    loadingServices.value = true;
    try {
      favServices.clear();
      final data = await supabase
          .from('serv_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<ServAssoc> assoc =
          data.map((json) => ServAssoc.fromMap(json)).toList();
      for (var element in assoc) {
        final event = await supabase
            .from('services')
            .select()
            .eq('servid', element.servid);
        List<ServiceModel> myEvent =
            event.map((json) => ServiceModel.fromMap(json)).toList();
        favServices.addAll(myEvent);
      }
    } catch (e) {
      print(e);
    }
    loadingServices.value = false;
  }

  getFavResources() async {
    loadingResources.value = true;
    try {
      favResources.clear();
      final data = await supabase
          .from('res_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<ResAssoc> assoc =
          data.map((json) => ResAssoc.fromMap(json)).toList();
      for (var element in assoc) {
        final event = await supabase
            .from('resources')
            .select()
            .eq('resid', element.resid);
        List<Resource> myEvent =
            event.map((json) => Resource.fromMap(json)).toList();
        favResources.addAll(myEvent);
      }
    } catch (e) {
      print(e);
    }
    loadingResources.value = false;
  }

  getFavOrganizations() async {
    loadingOrganizations.value = true;
    try {
      favOrganizations.clear();
      final data = await supabase
          .from('org_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<OrgAssoc> assoc =
          data.map((json) => OrgAssoc.fromMap(json)).toList();
      for (var element in assoc) {
        final event = await supabase
            .from('organizations')
            .select()
            .eq('orgid', element.orgid);
        List<Organization> myEvent =
            event.map((json) => Organization.fromMap(json)).toList();
        favOrganizations.addAll(myEvent);
      }
    } catch (e) {
      print(e);
    }
    loadingOrganizations.value = false;
  }

  getFavVideos() async {
    loadingVideos.value = true;
    try {
      favVideos.clear();
      final data = await supabase
          .from('vids_assoc')
          .select()
          .eq('userid', userController.user.value!.userid!);
      List<VideoAssoc> assoc =
          data.map((json) => VideoAssoc.fromMap(json)).toList();
      for (var element in assoc) {
        final event = await supabase
            .from('wellness_vids')
            .select()
            .eq('well_vid_id', element.well_vid_id);
        List<Video> myEvent = event.map((json) => Video.fromMap(json)).toList();
        favVideos.addAll(myEvent);
      }
    } catch (e) {
      print(e);
    }
    loadingVideos.value = false;
  }
}
