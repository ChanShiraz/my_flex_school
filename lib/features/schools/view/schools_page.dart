import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/schools/controller/schools_controller.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';
import 'package:my_flex_school/features/organizations/widgets/org_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resources_widget.dart';
import 'package:my_flex_school/features/schools/widgets/school_widget.dart';
import 'package:my_flex_school/features/services/widgets/services_widget.dart';

class SchoolsPage extends StatelessWidget {
  SchoolsPage({super.key, required this.selectedFeature, this.nearBy = false});
  final String selectedFeature;
  final SchoolsController schoolsController = Get.put(SchoolsController());
  final bool nearBy;

  @override
  Widget build(BuildContext context) {
    if (selectedFeature.contains('Schools')) {
      if (nearBy) {
        schoolsController.searchSchoolsNearBy();
      } else {
        schoolsController.searchSchools();
      }
    } else if (selectedFeature.contains('Resources')) {
      if (nearBy) {
        schoolsController.searchResourcesNearBy();
      } else {
        schoolsController.searchResources();
      }
    } else if (selectedFeature.contains('Services')) {
      if (nearBy) {
        schoolsController.searchServicesNearBy();
      } else {
        schoolsController.searchServices();
      }
    } else if (selectedFeature.contains('Organizations')) {
      if (nearBy) {
        schoolsController.searchOrganizationsNearBy();
      } else {
        schoolsController.searchOrganizations();
      }
    } else if (selectedFeature.contains('Events')) {
      if (nearBy) {
        schoolsController.searchEventsNearBy();
      } else {
        schoolsController.searchEvents();
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          selectedFeature,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                //schools part
                if (selectedFeature.contains('Schools')) {
                  return schoolsController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : schoolsController.schools.isEmpty
                          ? const Center(
                              child: Text(
                                'no result found!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: schoolsController.schools.length,
                                itemBuilder: (context, index) {
                                  return SchoolWidget(
                                    index: index,
                                    school: schoolsController.schools[index],
                                    onTap: () {
                                      Get.to(SchoolDetailsPage(
                                          index: index,
                                          school:
                                              schoolsController.schools[index],
                                          selectedFeature: selectedFeature));
                                    },
                                  );
                                },
                              ),
                            );
                }
                //resources part
                else if (selectedFeature.contains('Resources')) {
                  return schoolsController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : schoolsController.resources.isEmpty
                          ? const Center(
                              child: Text(
                                'no result found!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: schoolsController.resources.length,
                                itemBuilder: (context, index) {
                                  return ResourcesWidget(
                                    index: index,
                                    resource:
                                        schoolsController.resources[index],
                                    onTap: () {
                                      Get.to(
                                        SchoolDetailsPage(
                                            index: index,
                                            resource: schoolsController
                                                .resources[index],
                                            selectedFeature: selectedFeature),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                } else if (selectedFeature.contains('Services')) {
                  return schoolsController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : schoolsController.services.isEmpty
                          ? const Center(
                              child: Text(
                                'no result found!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: schoolsController.services.length,
                                itemBuilder: (context, index) {
                                  return ServicesWidget(
                                    index: index,
                                    services: schoolsController.services[index],
                                    onTap: () {
                                      Get.to(
                                        SchoolDetailsPage(
                                            index: index,
                                            services: schoolsController
                                                .services[index],
                                            selectedFeature: selectedFeature),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                }
                //organizations part
                else if (selectedFeature.contains('Organization')) {
                  return schoolsController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : schoolsController.organizations.isEmpty
                          ? const Center(
                              child: Text(
                                'no result found!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount:
                                    schoolsController.organizations.length,
                                itemBuilder: (context, index) {
                                  return OrgWidget(
                                    index: index,
                                    organization:
                                        schoolsController.organizations[index],
                                    onTap: () {
                                      Get.to(
                                        SchoolDetailsPage(
                                            index: index,
                                            organization: schoolsController
                                                .organizations[index],
                                            selectedFeature: selectedFeature),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                }
                //events part
                else if (selectedFeature.contains('Events')) {
                  return schoolsController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : schoolsController.events.isEmpty
                          ? const Center(
                              child: Text(
                                'no result found!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: schoolsController.events.length,
                                itemBuilder: (context, index) {
                                  return EventWidget(
                                    index: index,
                                    event: schoolsController.events[index],
                                    onTap: () {
                                      Get.to(
                                        SchoolDetailsPage(
                                            index: index,
                                            event:
                                                schoolsController.events[index],
                                            selectedFeature: selectedFeature),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
