import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.school});
  //Listing listing;
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
              DetailsTextWidget(
                keyO: 'City:',
                widget: Text(school.city),
              ),
              DetailsTextWidget(
                keyO: 'Address 1: ',
                widget: Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(school.address1)),
                ),
              ),
              school.address2 != null
                  ? DetailsTextWidget(
                      keyO: 'Address 2: ',
                      widget: Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(school.address2!),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              DetailsTextWidget(
                keyO: 'ZIP:',
                widget: Text(school.zip.toString()),
              ),
              DetailsTextWidget(
                keyO: 'Start Grade:',
                widget: Text(school.startGrade.toString()),
              ),
              DetailsTextWidget(
                keyO: 'End Grade:',
                widget: Text(school.endGrade.toString()),
              ),
              school.instructionalMethods != null
                  ? DetailsTextWidget(
                      keyO: 'Instructional Method:',
                      widget: Text(school.instructionalMethods!),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
