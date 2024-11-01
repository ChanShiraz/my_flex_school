import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/schools/controller/save_event_controller.dart';
import 'package:my_flex_school/features/my_schools/controller/save_school_controller.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/schools/widgets/event_details_widget.dart';
import 'package:my_flex_school/features/resources/widgets/resource_contact_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatefulWidget {
  EventDetailsPage({super.key, required this.event, required this.index});
  final Event event;
  bool isSaved = false;
  final int index;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final SaveEventController saveController = Get.put(SaveEventController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.event.eventid);
    setState(() {
      widget.isSaved = savedStatus;
    });
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (widget.isSaved) {
      await saveController.unSaveEvent(widget.event.eventid, widget.index);
    } else {
      await saveController.saveEvent(widget.event.eventid);
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
                    widget.event.name,
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
                widget.event.description,
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
            EventDetailsWidget(
              event: widget.event,
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
              contact: widget.event.contactPhone.toString(),
              name: widget.event.contactPerson,
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
                  if (!await launchUrl(Uri.parse(widget.event.website))) {
                    print('Could not launch');
                  }
                },
                child: Text(
                  widget.event.website,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
