import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/my_schools/controller/my_school_controller.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/school_widget.dart';

class MySchoolPage extends StatelessWidget {
  MySchoolPage({super.key});
  final MySchoolController schoolController = Get.put(MySchoolController());

  @override
  Widget build(BuildContext context) {
    if (schoolController.mySchools.isEmpty) {
      schoolController.getMySchools();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Schools',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => schoolController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: schoolController.mySchools.length,
                  itemBuilder: (context, index) {
                    return SchoolWidget(
                      index: index,
                      school: schoolController.mySchools[index],
                      onTap: () {
                        Get.to(SchoolDetailsPage(
                            index: index,
                            school: schoolController.mySchools[index],
                            selectedFeature: 'Flex School'));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
