import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/services/controller/save_serv_controller.dart';

class ServicesWidget extends StatefulWidget {
  const ServicesWidget(
      {super.key,
      required this.services,
      required this.onTap,
      required this.index});
  final ServiceModel services;
  final VoidCallback onTap;
  final int index;

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  final SaveServController saveController = Get.put(SaveServController());
  bool isLoading = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.services.servid);

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
      await saveController.unSave(widget.services.servid, widget.index);
    } else {
      await saveController.save(widget.services.servid);
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
                      widget.services.name,
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
                child: Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  widget.services.description,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
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
                          widget.services.city),
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
                          widget.services.address1),
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
