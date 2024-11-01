import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/notifications/controller/notification_controller.dart';
import 'package:my_flex_school/features/notifications/widgets/event_notifcation_widget.dart';
import 'package:my_flex_school/features/notifications/widgets/school_notification_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  UserController userController = Get.put(UserController());
  @override
  void initState() {
    notificationController
        .getSchoolNotifications(userController.user.value!.userid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => notificationController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            notificationController.schoolNotifications.length,
                        itemBuilder: (context, index) {
                          return SchoolNotificationWidget(
                              controller: notificationController,
                              notification: notificationController
                                  .schoolNotifications[index]);
                        },
                      ),
                      notificationController.isLoading.value
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: notificationController
                                  .eventNotifications.length,
                              itemBuilder: (context, index) {
                                return EventNotificationWidget(
                                    controller: notificationController,
                                    notification: notificationController
                                        .eventNotifications[index]);
                              },
                            ),
                    ],
                  ),
          )),
    );
  }
}
