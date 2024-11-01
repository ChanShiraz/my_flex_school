import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:my_flex_school/features/videos/model/video_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerController extends GetxController {
  final UserController userController = Get.put(UserController());
  PlayerController({required this.video});
  SupabaseClient supabase = Supabase.instance.client;

  late YoutubePlayerController? controller;
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;
  RxBool isVideoLoading = true.obs;
  final Video video;
  Completer<void>? _initializationCompleter;
  @override
  void onInit() {
    super.onInit();
    initializeVideo();
  }

  void initializeVideo() async {
    isVideoLoading.value = true;
    String? videoId = YoutubePlayer.convertUrlToId(video.path);
    if (videoId != null) {
      _initializationCompleter = Completer<void>();
      controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, enableCaption: false),
      );
      isVideoLoading.value = false;
      _initializationCompleter?.complete();
      _initializationCompleter = null;
      update();
      addVideoView();
    } else {
      //Get.rawSnackbar(message: 'Error while playing video!');
    }
  }

  addVideoView() async {
    VideoView view = VideoView(
        well_vid_id: video.wellVidId,
        userid: userController.user.value!.userid!,
        date_viewed: DateTime.now());
    await supabase.from('wellness_vid_views').insert(view.toMap());
  }

  @override
  void onClose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.onClose();
  }

  void clearVideosPlayer() async {
    if (_initializationCompleter != null) {
      await _initializationCompleter!.future;
    }
    if (controller != null) {
      controller!.dispose();
    }
    update();
  }
}
