import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class HomeVideo extends StatefulWidget {
  final String videoUrl ;
  final String thumbnailUrl;
  const HomeVideo(
      {Key? key, required this.videoUrl, required this.thumbnailUrl})
      : super(key: key);

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  bool playVideo = false;
  late VideoPlayerController _player;

  @override
  void initState() {
    video(widget.videoUrl);
    super.initState();
  }

  void video(String url) async {
    WidgetsFlutterBinding.ensureInitialized();
    _player = VideoPlayerController.network(
      // 'https://youtu.be/yTCDVfMz15M'
      'https://www.batnf.net/$url'
    );
    _player.addListener(() => setState(() {}));
    _player.setLooping(false);
    _player.addListener(listener);
    _player.initialize().then((value) => _player.pause());
    Wakelock.enable();
  }

  void listener() async {
    await Future.delayed(const Duration(milliseconds: 1));
    setState(() {});
  }

  @override
  void dispose() {
    _player.dispose();
    _player.removeListener((listener));
    super.dispose();
  }

  String getPosition() {
    final duration =
        Duration(milliseconds: _player.value.position.inMilliseconds.round());
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
        alignment: AlignmentDirectional.center,
        children: [
          CachedNetworkImage(
            errorWidget: (context, url, error) => Center(child: Text('Error Loading Images'),),
            placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            imageUrl:
            //  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
            'https://www.batnf.net/${widget.thumbnailUrl}',
            fit: BoxFit.cover,
          ),
          // Container(
          //   height: double.maxFinite,
          //   width: double.maxFinite,
          //   color: Colors.transparent,
          //   child: Image.asset('assets/Bc.png'),
          // ),
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
                  backgroundColor: Colors.black.withOpacity(0.29),
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
        ClipRect(
          child: AspectRatio(
              aspectRatio:
                  // 16 / 19,
                  _player.value.aspectRatio,
              child: VideoPlayer(_player)),
        ),
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
                  : const Icon(
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
            bottom: 5,
            left: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getPosition(),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  ' / ',
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
