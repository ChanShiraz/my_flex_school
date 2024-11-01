import 'package:cached_network_image/cached_network_image.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/organizations/widgets/org_details_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resource_contact_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationDetailsPage extends StatefulWidget {
  OrganizationDetailsPage(
      {super.key, required this.organization, required this.index});
  final Organization organization;
  bool isSaved = false;
  final int index;

  @override
  State<OrganizationDetailsPage> createState() =>
      _OrganizationDetailsPageState();
}

class _OrganizationDetailsPageState extends State<OrganizationDetailsPage> {
  final OrgSaveController saveController = Get.put(OrgSaveController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus =
        await saveController.checkSave(widget.organization.orgid);
    setState(() {
      widget.isSaved = savedStatus;
    });
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (widget.isSaved) {
      await saveController.unSave(widget.organization.orgid, widget.index);
    } else {
      await saveController.save(widget.organization.orgid);
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
                    widget.organization.name,
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
                    Floatable(
                        float: FCFloat.start,
                        // maxWidthPercentage: 0.33,
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 150,
                            width: 150,
                            imageUrl: widget.organization.avatar,
                          ),
                        )),
                    WrappableText(
                        text: TextSpan(text: widget.organization.description)),
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
            OrgDetailsWidget(
              organization: widget.organization,
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
            ResourceContactWidget(
              contact: widget.organization.contactPhone.toString(),
              name: widget.organization.contactPerson,
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
                  if (!await launchUrl(
                      Uri.parse(widget.organization.website))) {
                    print('Could not launch');
                  }
                },
                child: Text(
                  widget.organization.website,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
