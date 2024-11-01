import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/my_schools/controller/save_school_controller.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/view/school_details_page.dart';
import 'package:my_flex_school/features/schools/widgets/school_details_widget.dart';
import 'package:float_column/float_column.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetailsPageR extends StatefulWidget {
  SchoolDetailsPageR({super.key, required this.school, required this.index});
  final School school;
  bool isSaved = false;
  final int index;

  @override
  State<SchoolDetailsPageR> createState() => _SchoolDetailsPageRState();
}

class _SchoolDetailsPageRState extends State<SchoolDetailsPageR> {
  final SaveSchoolController saveController = Get.put(SaveSchoolController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _checkSaveStatus();
    }
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.school.fsid);
    setState(() {
      widget.isSaved = savedStatus;
    });
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (widget.isSaved) {
      await saveController.unSaveSchool(widget.school.fsid, widget.index);
    } else {
      await saveController.saveSchool(widget.school.fsid);
    }
    setState(() {
      widget.isSaved = !widget.isSaved;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.school.name,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: _handleSaveUnsave,
                        icon: Icon(
                          widget.isSaved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              widget.isSaved ? Colors.red : AppColors.mainColor,
                        ),
                      ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: FloatColumn(
                  children: [
                    widget.school.logo != null
                        ? Floatable(
                            float: FCFloat.start,
                            // maxWidthPercentage: 0.33,
                            padding: const EdgeInsetsDirectional.only(end: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                                imageUrl: widget.school.logo!,
                              ),
                            ))
                        : const SizedBox(),
                    WrappableText(
                        text: TextSpan(text: widget.school.description)),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            DetailsWidget(
              school: widget.school,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Contact',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            ContactWidget(
              school: widget.school,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Website',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            TextButton(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(widget.school.website))) {
                    print('Could not launch');
                  }
                },
                child: Text(
                  widget.school.website,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
