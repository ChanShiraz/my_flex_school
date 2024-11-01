import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/resources/controller/save_res_controller.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/resources/widgets/resource_contact_widget.dart';
import 'package:my_flex_school/features/services/controller/save_serv_controller.dart';
import 'package:my_flex_school/features/services/widgets/services_details_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsPage extends StatefulWidget {
  ServiceDetailsPage({super.key, required this.services, required this.index});
  final ServiceModel services;
  bool isSaved = false;
  final int index;

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  final SaveServController saveController = Get.put(SaveServController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.services.servid);
    setState(() {
      widget.isSaved = savedStatus;
    });
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (widget.isSaved) {
      await saveController.unSave(widget.services.servid, widget.index);
    } else {
      await saveController.save(widget.services.servid);
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
                    widget.services.name,
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
              child: Text(
                widget.services.description,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
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
            ServicesDetailsWidget(
              service: widget.services,
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
              contact: widget.services.contactPhone,
              name: widget.services.contactPerson,
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
                  if (!await launchUrl(Uri.parse(widget.services.website))) {
                    print('Could not launch');
                  }
                },
                child: Text(
                  widget.services.website,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
