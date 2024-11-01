import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flex_school/features/videos/controller/video_save_controller.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/videos/view/player_page.dart';
import 'package:my_flex_school/features/videos/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final Video video;
  final int index;
  //final ThumbnailController controller = Get.put(ThumbnailController());

  const VideoWidget({super.key, required this.video, required this.index});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  final VideoSaveController saveController = Get.put(VideoSaveController());
  bool isLoading = false;
  bool isSaved = false;
  String? videoId;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.video.path);
    _checkSaveStatus();
  }

  Future<void> _checkSaveStatus() async {
    final savedStatus = await saveController.checkSave(widget.video.wellVidId);

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
      await saveController.unSave(widget.video.wellVidId, widget.index);
    } else {
      await saveController.save(widget.video.wellVidId);
    }
    setState(() {
      isSaved = !isSaved;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkSaveStatus();
    double height = MediaQuery.of(context).size.height * 0.26;
    double width = MediaQuery.of(context).size.width;

    // Start generating or fetching the thumbnail for this video.
    //controller.generateThumb(video.path);

    return InkWell(
      onTap: () {
        if (videoId == null) {
          Get.rawSnackbar(message: 'Unable to play video!');
        } else {
          Get.to(PlayerPage(
            video: widget.video,
            index: widget.index,
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                videoId != null
                    ? CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: "https://img.youtube.com/vi/$videoId/0.jpg",
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      )
                    : const SizedBox(),
                Positioned(
                  right: 0,
                  child: isLoading
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
                            color: isSaved ? Colors.red : Colors.white,
                          ),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.mainColor],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 15,
                  child: SizedBox(
                    width: width * 0.4,
                    child: Text(
                      widget.video.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.play_circle,
                    color: AppColors.mainColor,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThumbnailController extends GetxController {
  final Map<String, Uint8List?> thumbnailCache = {};

  Future<void> generateThumb(String videoUrl) async {
    // Check if the thumbnail is already cached.
    if (thumbnailCache[videoUrl] == null) {
      final Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.WEBP,
        maxHeight: 180,
        quality: 50,
      );

      thumbnailCache[videoUrl] = thumbnail;
      update([videoUrl]);
    }
  }
}
