import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/resources/controller/save_res_controller.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';

class ResourcesWidget extends StatefulWidget {
  const ResourcesWidget(
      {super.key,
      required this.resource,
      required this.onTap,
      required this.index});
  final Resource resource;
  final VoidCallback onTap;
  final int index;

  @override
  State<ResourcesWidget> createState() => _ResourcesWidgetState();
}

class _ResourcesWidgetState extends State<ResourcesWidget> {
  final SaveResController saveController = Get.put(SaveResController());
  bool isLoading = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.resource.resid);

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
      await saveController.unSave(widget.resource.resid, widget.index);
    } else {
      await saveController.save(widget.resource.resid);
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
                      widget.resource.name,
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
                  widget.resource.description,
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
                          widget.resource.city),
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
                          widget.resource.address1),
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
