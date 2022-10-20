// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/files.dart';
import '../providers/news_provider.dart';

class NewsDetails extends StatefulWidget {
  final NewsModel singleNews;
  NewsDetails(this.singleNews, {Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  List<CachedVideoPlayerController> playerController = [];
  
  @override
  void initState() {
    super.initState();
    video(widget.singleNews.files!);
    // Provider.of<NewsProvider>(context, listen: false).getAllNews();
  }
  void video(List<Files> file) async {
    if (file.isEmpty) return;
    List<Files> videoList =
        file.where((element) => element.fileExt == 'video/mp4').toList();
    int count =
        videoList.fold(0, (previousValue, element) => previousValue + 1);
    playerController = List.generate(
        count,
        (index) => CachedVideoPlayerController.network(
            'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
            // widget.singlePending.files![index].fileUrl
            // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            ));

    for (var element in playerController) {
      element.initialize().then((value) async {
        await Future.delayed(Duration(milliseconds: 500));
        // element.play();
        setState(() {});
      });
    }
  }
  
  @override
  void dispose() {
    for (var element in playerController) {
      element.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kButtonColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //News title
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      widget.singleNews.title,
                      style: kPageHeader,
                    ),
                    Text('Dec 21 2021')
                  ],
                ),
              ),

              //News Image
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlayInterval: Duration(seconds: 10),
                    height: 350,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    // autoPlay: true
                  ),
                  items: widget.singleNews.files!.map((newsFile) {
                    if (newsFile.fileExt == 'image/jpeg') {
                      return CachedNetworkImage(
                          errorWidget: (context, url, error) =>
                              Center(child: Text('No Image/Video Available')),
                          placeholder: (context, url) => Center(
                                  child: Text(
                                'Loading',
                                style: TextStyle(color: Colors.black),
                              )),
                          imageUrl:
                              'https://www.batnf.net/${newsFile.fileUrl}',
                          fit: BoxFit.cover);
                    }
                    CachedVideoPlayerController controller =
                        playerController.firstWhere((element) =>
                                element.dataSource ==
                                'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
                            // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                            // newsFile.fileUrl
                            );
                    return controller.value.isInitialized
                        ? Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              AspectRatio(
                                  aspectRatio: 6 / 6,
                                  // controller.value.aspectRatio,
                                  child: CachedVideoPlayer(controller)),
                              GestureDetector(
                                onTap: () {
                                  if (!controller.value.isInitialized) return;
                                  setState(
                                    () {
                                      controller.value.isPlaying
                                          ? controller.pause()
                                          : controller.play();
                                    },
                                  );
                                },
                                child: Icon(
                                  controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: kButtonColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator());
                  }).toList()),

              // New Details
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singleNews.information,
                  textAlign: TextAlign.justify,
                  style: kBodyTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
