import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';
import 'package:my_flex_school/features/services/widgets/services_widget.dart';

class FavServicesPage extends StatefulWidget {
  const FavServicesPage({super.key});

  @override
  State<FavServicesPage> createState() => _FavServicesPageState();
}

class _FavServicesPageState extends State<FavServicesPage> {
  final FavController favController = Get.put(FavController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favController.favServices.isEmpty) {
        favController.getFavServices();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => favController.loadingServices.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favController.favServices.length,
                itemBuilder: (context, index) {
                  return ServicesWidget(
                    index: index,
                    services: favController.favServices[index],
                    onTap: () {
                      Get.to(SchoolDetailsPage(
                          index: index,
                          services: favController.favServices[index],
                          selectedFeature: 'Service'));
                    },
                  );
                },
              ),
      ),
    );
  }
}
