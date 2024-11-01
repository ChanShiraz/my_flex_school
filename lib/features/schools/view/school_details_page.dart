import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/schools/widgets/details_pages/event_details_page.dart';
import 'package:my_flex_school/features/organizations/view/organization_details_page.dart';
import 'package:my_flex_school/features/resources/view/resource_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/details_pages/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_details_widget.dart';
import 'package:my_flex_school/features/organizations/widgets/org_details_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resource_contact_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resource_details_widget.dart';
import 'package:my_flex_school/features/schools/widgets/school_details_widget.dart';
import 'package:my_flex_school/features/services/view/service_details_page.dart';
import 'package:my_flex_school/features/services/widgets/services_details_widget.dart';

class SchoolDetailsPage extends StatelessWidget {
  const SchoolDetailsPage(
      {super.key,
      required this.index,
      this.school,
      required this.selectedFeature,
      this.resource,
      this.services,
      this.organization,
      this.event,
      this.isSaved = false});
  final int index;
  final String selectedFeature;
  final School? school;
  final Resource? resource;
  final ServiceModel? services;
  final Organization? organization;
  final Event? event;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            '$selectedFeature Details',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body:
            //school part
            school != null
                ? SchoolDetailsPageR(
                    school: school!,
                    index: index,
                  )
                : resource != null
                    ?
                    //resources part
                    ResourceDetailsPage(resource: resource!,index: index,)
                    : selectedFeature.contains('Service')
                        ?
                        //services part
                        ServiceDetailsPage(
                            services: services!,
                            index: index,
                          )
                        : organization != null
                            ? OrganizationDetailsPage(
                                organization: organization!,
                                index: index,
                              )
                            : EventDetailsPage(
                                event: event!,
                                index: index,
                              ));
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.school});
  final School school;

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
              school.contactPerson != null
                  ? DetailsTextWidget(
                      keyO: 'Contact Person:',
                      widget: Text(school.contactPerson!),
                    )
                  : const SizedBox.shrink(),
              DetailsTextWidget(
                keyO: 'Phone:',
                widget: Text(school.contactPhone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//details inner widget
class DetailsTextWidget extends StatelessWidget {
  DetailsTextWidget({super.key, required this.keyO, required this.widget});
  @override
  String keyO;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(keyO), widget],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
