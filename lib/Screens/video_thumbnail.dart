import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  const Videos({Key? key, required this.videoUrl, required this.thumbnailUrl})
      : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  bool playVideo = false;
  late CachedVideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    initializePlayer(widget.videoUrl);
  }

  void initializePlayer(String url) async {
    _playerController =
        CachedVideoPlayerController.network('https://www.batnf.net/$url');
    await _playerController.initialize();
    _playerController.addListener(listener);
  }

  void listener() async {
    await Future.delayed(const Duration(milliseconds: 1));
    setState(() {});
  }

  @override
  void dispose() {
    _playerController.removeListener(listener);
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!playVideo) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CachedNetworkImage(
            errorWidget: (context, url, error) => Container(),
            // ignore: prefer_const_constructors
            placeholder: (context, url) => Center(
              child: const Text(
                'Loading...',
                style: TextStyle(color: Colors.black),
              ),
            ),
            imageUrl: 'https://www.batnf.net/${widget.thumbnailUrl}',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (_playerController.value.isInitialized) {
                  setState(() {
                    playVideo = true;
                  });
                  _playerController.play();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.blue.withOpacity(0.99),
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AspectRatio(
            aspectRatio:
                // 6 / 6,
                _playerController.value.aspectRatio,
            child: CachedVideoPlayer(_playerController)),
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              _playerController.value.isPlaying
                  ? _playerController.pause()
                  : _playerController.play();
            },
            child: Container(
              color: Colors.transparent,
              // height: double.maxFinite,
              child: _playerController.value.isPlaying
                  ? const SizedBox.expand()
                  : Icon(
                      Icons.play_arrow,
                      color: Colors.blue.withOpacity(0.5),
                      size: 30,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
