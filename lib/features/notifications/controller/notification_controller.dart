import 'package:get/get.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/notifications/models/event_notification.dart';
import 'package:my_flex_school/features/notifications/models/school_notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;
  RxBool isLoading = false.obs;
  RxInt notificationsCount = 0.obs;
  RxInt notificationsCountE = 0.obs;
  RxList<SchoolNotification> schoolNotifications = <SchoolNotification>[].obs;
  RxList<EventNotification> eventNotifications = <EventNotification>[].obs;
  //UserController userController = Get.put(UserController());
  getSchoolNotificationsCount(int userid) async {
    notificationsCount.value = 0;
    try {
      supabase
          .from('fs_notification_reads')
          .stream(primaryKey: ['fsnrid'])
          .eq('userid', userid)
          .listen((List<Map<String, dynamic>> data) {
            final filteredData =
                data.where((event) => event['read_date'] == null).toList();
            print('stream changed');
            notificationsCount.value = filteredData.length;
            getEventNotificationsCount(userid, notificationsCount.value);
          });
    } catch (e) {
      print(e);
    }
  }

  getEventNotificationsCount(int userid, int schoolLength) async {
    try {
      supabase
          .from('event_notification_reads')
          .stream(primaryKey: ['enrid'])
          .eq('userid', userid)
          .listen((List<Map<String, dynamic>> data) {
            final filteredData =
                data.where((event) => event['read_date'] == null).toList();
            print('stream changed');
            notificationsCount.value = filteredData.length + schoolLength;
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSchoolNotifications(int userid) async {
    isLoading.value = true;
    schoolNotifications.clear();
    try {
      final schools = await supabase
          .from('flex_school_assoc')
          .select()
          .eq('userid', userid);
      for (var element in schools) {
        final notificationsData = await supabase
            .from('fs_notifications')
            .select()
            .eq('fsid', element['fsid']);
        List<SchoolNotification> notifications = notificationsData
            .map((json) => SchoolNotification.fromMap(json))
            .toList();
        schoolNotifications.addAll(notifications);
        await getEventsNotifications(userid);
        markReadSchool(userid);
      }
    } catch (e) {
      print('Error in notifications $e');
      Get.rawSnackbar(message: 'Error while fetching error $e');
    }
    isLoading.value = false;
  }

  Future<void> getEventsNotifications(int userid) async {
    isLoading.value = true;
    eventNotifications.clear();
    try {
      final schools =
          await supabase.from('event_assoc').select().eq('userid', userid);

      for (var element in schools) {
        final notificationsData = await supabase
            .from('event_notifications')
            .select()
            .eq('eventid', element['eventid']);

        List<EventNotification> notifications = notificationsData
            .map((json) => EventNotification.fromMap(json))
            .toList();
        eventNotifications.addAll(notifications);
        markReadEvent(userid);
      }
    } catch (e) {
      print('Error in notifications $e');
      Get.rawSnackbar(message: 'Error while fetching error $e');
    }
    isLoading.value = false;
  }

  Future<String> getSchoolName(int fsid) async {
    try {
      final school =
          await supabase.from('flexschools').select().eq('fsid', fsid);
      return school[0]['name'];
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  Future<String> getEventName(int eventid) async {
    try {
      final school =
          await supabase.from('events').select().eq('eventid', eventid);
      return school[0]['name'];
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  markReadSchool(int userid) async {
    try {
      await supabase
          .from('fs_notification_reads')
          .update({'read_date': DateTime.now().toIso8601String()})
          .eq('userid', userid)
          .isFilter('read_date', null);
    } catch (e) {
      print('error while mark read $e');
    }
  }

  markReadEvent(int userid) async {
    try {
      await supabase
          .from('event_notification_reads')
          .update({'read_date': DateTime.now().toIso8601String()})
          .eq('userid', userid)
          .isFilter('read_date', null);
    } catch (e) {
      print('error while mark read $e');
    }
  }
}
