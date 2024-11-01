import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';

class ResourceDetailsWidget extends StatelessWidget {
  const ResourceDetailsWidget({super.key, required this.resource});
  //Listing listing;
  final Resource resource;
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
                widget: Text(resource.city),
              ),
              DetailsTextWidget(
                keyO: 'State:',
                widget: Text(resource.state),
              ),
              DetailsTextWidget(
                keyO: 'Address 1: ',
                widget: Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(resource.address1)),
                ),
              ),
              resource.address2 != null
                  ? DetailsTextWidget(
                      keyO: 'Address 2: ',
                      widget: Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(resource.address2!))),
                    )
                  : const SizedBox.shrink(),
              DetailsTextWidget(
                keyO: 'ZIP:',
                widget: Text(resource.zip.toString()),
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
