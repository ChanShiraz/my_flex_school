import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/organizations/widgets/org_details_widget.dart';
import 'package:my_flex_school/features/organizations/widgets/org_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resources_widget.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';

class FavOrganizationsPage extends StatefulWidget {
  const FavOrganizationsPage({super.key});

  @override
  State<FavOrganizationsPage> createState() => _FavOrganizationsPageState();
}

class _FavOrganizationsPageState extends State<FavOrganizationsPage> {
  final FavController favController = Get.put(FavController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favController.favOrganizations.isEmpty) {
        favController.getFavOrganizations();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => favController.loadingOrganizations.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favController.favOrganizations.length,
                itemBuilder: (context, index) {
                  return OrgWidget(
                    organization: favController.favOrganizations[index],
                    index: index,
                    onTap: () {
                      Get.to(
                        SchoolDetailsPage(
                           index: index,
                            organization: favController.favOrganizations[index],
                            selectedFeature: 'Organization'),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
