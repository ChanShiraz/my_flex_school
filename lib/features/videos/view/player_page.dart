import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/videos/controller/player_controller.dart';
import 'package:my_flex_school/features/videos/controller/video_save_controller.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerPage extends StatefulWidget {
  PlayerPage({super.key, required this.video, required this.index});
  final Video video;
  bool isSaved = false;
  final int index;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late PlayerController playerController;

  final VideoSaveController saveController = Get.put(VideoSaveController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    playerController = Get.put(PlayerController(video: widget.video));
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.video.wellVidId);
    setState(() {
      widget.isSaved = savedStatus;
    });
  }

  Future<void> _handleSaveUnsave() async {
    setState(() {
      isLoading = true;
    });
    if (widget.isSaved) {
      await saveController.unSave(widget.video.wellVidId, widget.index);
    } else {
      await saveController.save(widget.video.wellVidId);
    }
    setState(() {
      widget.isSaved = !widget.isSaved;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvoked: (didPop) {
        //playerController.clearVideosPlayer();
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Wellness Video',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            backgroundColor: AppColors.mainColor,
          ),
          body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: playerController.controller!,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        //height: height * 0.38,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<PlayerController>(
                              builder: (controller) {
                                return controller.isVideoLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : playerController.controller == null
                                        ? const SizedBox()
                                        : player;
                                // YoutubePlayer(
                                //     controller: playerController.controller!,
                                //     showVideoProgressIndicator: true,
                                //   );
                              },
                            ),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.video.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
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
                                            color: widget.isSaved
                                                ? Colors.red
                                                : AppColors.white,
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          widget.video.description,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
