import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/notifications/controller/notification_controller.dart';
import 'package:my_flex_school/features/notifications/models/event_notification.dart';
import 'package:my_flex_school/features/notifications/models/school_notification.dart';

class EventNotificationWidget extends StatelessWidget {
  const EventNotificationWidget(
      {super.key, required this.notification, required this.controller});
  final EventNotification notification;
  final NotificationController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      notification.name,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // isLoading
                  //     ? const Padding(
                  //         padding: EdgeInsets.all(14),
                  //         child: SizedBox(
                  //           height: 20,
                  //           width: 20,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 1,
                  //           ),
                  //         ),
                  //       )
                  //     : IconButton(
                  //         onPressed: _handleSaveUnsave,
                  //         icon: Icon(
                  //           isSaved
                  //               ? Icons.bookmark_outlined
                  //               : Icons.bookmark_border_outlined,
                  //           color: AppColors.mainColor,
                  //         ),
                  //       ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  notification.description,
                  style: const TextStyle(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('hh:mm aa dd-mmm-yyy')
                    .format(notification.createdTime),
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              FutureBuilder(
                future: controller.getEventName(notification.enid),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.event_note,
                          color: Colors.black54,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot.data!,
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
