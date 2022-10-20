import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_video_player/cached_video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late CachedVideoPlayerController controller;
  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;

  @override
  void initState() {
    // _videoPlayerController = VideoPlayerController.network(
    //     // 'assets/movie.mp4'
    //     // 'https://youtu.be/-LPe4tYckkg?t=3'
    //     'www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
    //     );
    // _videoPlayerController!.initialize().then((_) {
    //   // _chewieController =
    //   //     ChewieController(videoPlayerController: _videoPlayerController!);
    //   _videoPlayerController!.play();
    //   setState(() {});
    // });

    controller = CachedVideoPlayerController.network(
        'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        );
    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();

    // _videoPlayerController!.dispose();
    // _chewieController!.dispose();
    // super.dispose();
  }

  // Widget _chewieVideoPlayer() {
  //   return _chewieController != null && _videoPlayerController != null
  //       ? Container(
  //           width: 335,
  //           child: Chewie(controller: _chewieController!),
  //         )
  //       : Center(child: const CircularProgressIndicator());
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CachedVideoPlayer(controller))
              : const CircularProgressIndicator()),
      // _chewieVideoPlayer(),
    );
  }
}
