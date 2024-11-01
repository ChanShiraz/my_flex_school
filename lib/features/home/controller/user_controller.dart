import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/auth/model/user.dart';
import 'package:my_flex_school/features/auth/view/login_page.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/my_schools/controller/my_school_controller.dart';
import 'package:my_flex_school/features/notifications/controller/notification_controller.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/resources/controller/save_res_controller.dart';
import 'package:my_flex_school/features/schools/controller/save_event_controller.dart';
import 'package:my_flex_school/features/schools/controller/schools_controller.dart';
import 'package:my_flex_school/features/services/controller/save_serv_controller.dart';
import 'package:my_flex_school/features/spa/controller/spa_controller.dart';
import 'package:my_flex_school/features/videos/controller/video_save_controller.dart';
import 'package:my_flex_school/features/videos/controller/videos_controller.dart';
import 'package:my_flex_school/utils/extensions/snackbar_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

class UserController extends GetxController {
  NotificationController notificationController =
      Get.put(NotificationController());
  SupabaseClient supabase = Supabase.instance.client;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool loadingUser = false.obs;
  getUser() async {
    loadingUser.value = true;
    try {
      final User? supabaseUser = supabase.auth.currentUser;
      if (supabaseUser != null) {
        final userData =
            await supabase.from('users').select().eq('uid', supabaseUser.id);
        UserModel userModel = UserModel.fromMap(userData.first);
        user.value = userModel;
        notificationController.getSchoolNotificationsCount(userModel.userid!);
        // notificationController.getEventNotificationsCount(userModel.userid!);
      }
    } catch (e) {
      print('Error $e');
      Get.rawSnackbar(message: 'Some error occured : $e');
    }
    loadingUser.value = false;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      // isLoading.value = true;
      await supabase.auth.signOut();
      Get.delete<UserController>();
      Get.delete<SpaController>();
      Get.delete<FavController>();
      Get.delete<NotificationController>();
      Get.delete<VideosController>();
      Get.delete<VideoPlayerController>();
      Get.delete<SchoolsController>();
      Get.delete<SchoolsController>();
      Get.delete<MySchoolController>();
      Get.delete<SaveServController>();
      Get.delete<SaveEventController>();
      Get.delete<SaveResController>();
      Get.delete<OrgSaveController>();
      Get.delete<VideoSaveController>();
    } on AuthException catch (error) {
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    } finally {
      // isLoading.value = false;
      Get.offAll(() => const LoginPage());
    }
  }
}
