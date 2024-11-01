import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flex_school/features/fav/controller/fav_controller.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/event_widget.dart';

class FavEventPage extends StatefulWidget {
  const FavEventPage({super.key});

  @override
  State<FavEventPage> createState() => _FavEventPageState();
}

class _FavEventPageState extends State<FavEventPage> {
  final FavController favController = Get.put(FavController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favController.favEvents.isEmpty) {
        favController.getFavEvents();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => favController.loadingEvents.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favController.favEvents.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    index: index,
                    event: favController.favEvents[index],
                    onTap: () {
                      Get.to(SchoolDetailsPage(
                          index: index,
                          event: favController.favEvents[index],
                          selectedFeature: 'Event'));
                    },
                  );
                },
              ),
      ),
    );
  }
}
