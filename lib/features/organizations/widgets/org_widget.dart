import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/organizations/controller/org_save_controller.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/service.dart';

class OrgWidget extends StatefulWidget {
  const OrgWidget(
      {super.key,
      required this.organization,
      required this.onTap,
      required this.index});
  final Organization organization;
  final VoidCallback onTap;
  final int index;

  @override
  State<OrgWidget> createState() => _OrgWidgetState();
}

class _OrgWidgetState extends State<OrgWidget> {
  final OrgSaveController saveController = Get.put(OrgSaveController());
  bool isLoading = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus =
        await saveController.checkSave(widget.organization.orgid);

    if (mounted) {
      setState(() {
        isSaved = savedStatus;
      });
    }
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (isSaved) {
      await saveController.unSave(widget.organization.orgid, widget.index);
    } else {
      await saveController.save(widget.organization.orgid);
    }
    setState(() {
      isSaved = !isSaved;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkSaveStatus();
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.organization.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18,
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
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? Colors.red : AppColors.mainColor,
                          ),
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline,
                            color: Colors.black45,
                          ),
                          imageUrl: widget.organization.avatar,
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        widget.organization.description,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: AppColors.mainColor,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.organization.city),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.mainColor,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.organization.address1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
