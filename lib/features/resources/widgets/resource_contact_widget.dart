import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';

class ResourceContactWidget extends StatelessWidget {
  const ResourceContactWidget(
      {super.key, required this.contact, required this.name});

  final String? name;
  final String contact;
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
              name != null
                  ? DetailsTextWidget(
                      keyO: 'Contact Person:',
                      widget: Text(name!),
                    )
                  : const SizedBox.shrink(),
              DetailsTextWidget(
                keyO: 'Phone:',
                widget: Text(contact),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
