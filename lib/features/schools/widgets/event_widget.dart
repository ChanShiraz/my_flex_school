import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/controller/save_event_controller.dart';
import 'package:my_flex_school/features/my_schools/controller/save_school_controller.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/service.dart';

class EventWidget extends StatefulWidget {
  const EventWidget(
      {super.key,
      required this.event,
      required this.onTap,
      required this.index});
  final Event event;
  final VoidCallback onTap;
  final int index;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final SaveEventController saveController = Get.put(SaveEventController());
  bool isLoading = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.event.eventid);

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
      await saveController.unSaveEvent(widget.event.eventid, widget.index);
    } else {
      await saveController.saveEvent(widget.event.eventid);
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
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.event.name,
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
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  widget.event.description,
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
                          widget.event.city),
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
                          widget.event.address1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.mainColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(DateFormat('hh:mm aa - dd MMM yyyy')
                        .format(widget.event.start))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
