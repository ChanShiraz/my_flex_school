import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/resources/widgets/resources_widget.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';

class FavResourcesPage extends StatefulWidget {
  const FavResourcesPage({super.key});

  @override
  State<FavResourcesPage> createState() => _FavResourcesPageState();
}

class _FavResourcesPageState extends State<FavResourcesPage> {
  final FavController favController = Get.put(FavController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favController.favResources.isEmpty) {
        favController.getFavResources();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => favController.loadingResources.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favController.favResources.length,
                itemBuilder: (context, index) {
                  return ResourcesWidget(
                    index: index,
                    resource: favController.favResources[index],
                    onTap: () {
                      Get.to(
                        SchoolDetailsPage(
                           index: index,
                            resource: favController.favResources[index],
                            selectedFeature: 'Resource'),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
