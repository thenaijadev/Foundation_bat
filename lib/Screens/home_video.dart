// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/video_orientation.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:batnf/Screens/video_orientation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class HomeVideo extends StatefulWidget {
  const HomeVideo({super.key});

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  bool playVideo = false;
  late VideoPlayerController _player;

  @override
  void initState() {
    video();
    super.initState();
  }

  void video() {
     _player = VideoPlayerController.asset('assets/video.mp4');
    _player.addListener(() => setState(() {}));
    _player.setLooping(false);
    _player.initialize().then((value) => _player.pause());
     Wakelock.enable();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String getPosition() {
    final duration = Duration(
        milliseconds: _player.value.position.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

String getDuration() {
    final duration =
        Duration(milliseconds: _player.value.duration.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
  @override
  Widget build(BuildContext context) {
    if (!playVideo) {
      return Stack(
        // fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Image.asset('assets/Bc.png'),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                if (_player.value.isInitialized) {
                  setState(() {
                    playVideo = true;
                  });
                  _player.play();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor:  Colors.black.withOpacity(0.29),
                  maxRadius: 30,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.center,
      children: [
        AspectRatio(
            aspectRatio:
                // 16 / 19,
                _player.value.aspectRatio,
            child: VideoPlayer(_player)),
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {});
              _player.value.isPlaying ? _player.pause() : _player.play();
            },
            child: Container(
              color: Colors.transparent,
              // height: double.maxFinite,
              child: _player.value.isPlaying
                  ? const SizedBox.expand()
                  : Icon(
                      // Icons.play_arrow,
                      FontAwesomeIcons.playCircle,
                      color: Colors.black,
                      size: 60,
                    ),
            ),
          ),
        ),
        //video progress timer
        Positioned(
            bottom: 18,
            left: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getPosition(),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '/',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  getDuration(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ],
    );
  }
}
