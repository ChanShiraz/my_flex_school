import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';

class EventDetailsWidget extends StatelessWidget {
  const EventDetailsWidget({super.key, required this.event});
  //Listing listing;
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DetailsTextWidget(
                keyO: 'City:',
                widget: Text(event.city),
              ),
              DetailsTextWidget(
                keyO: 'State:',
                widget: Text(event.state),
              ),
              DetailsTextWidget(
                keyO: 'Address 1: ',
                widget: Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(event.address1)),
                ),
              ),
              event.address2 != null
                  ? DetailsTextWidget(
                      keyO: 'Address 2: ',
                      widget: Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(event.address2!))),
                    )
                  : const SizedBox.shrink(),
              DetailsTextWidget(
                  keyO: 'Starts At:',
                  widget: Text(DateFormat('hh:mm aa - dd MMM yyyy')
                      .format(event.start))),
              DetailsTextWidget(
                  keyO: 'End At:',
                  widget: Text(
                      DateFormat('hh:mm aa - dd MMM yyyy').format(event.end))),
              DetailsTextWidget(
                keyO: 'ZIP:',
                widget: Text(event.zip.toString()),
              ),
              // listing.conditon != null
              //     ? DetailsTextWidget(
              //         keyO: 'Condition:',
              //         value: listing.conditon!,
              //       )
              //     : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
