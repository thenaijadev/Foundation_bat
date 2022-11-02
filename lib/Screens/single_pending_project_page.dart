// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/files.dart';
import '../Models/pending_model.dart';
import '../constants/color_constant.dart';
import '../constants/text_style_constant.dart';

class PendingDetails extends StatefulWidget {
  final PendingModel singlePending;
  const PendingDetails( this.singlePending, {super.key});

  @override
  State<PendingDetails> createState() => _PendingDetailsState();
}

class _PendingDetailsState extends State<PendingDetails> {
  List<CachedVideoPlayerController> playerController = [];

@override
void initState() {
    video(widget.singlePending.files!);
  super.initState();
  // Implement some initialization operations here.
}


  void video(List<Files> file) async {
    if (file.isEmpty) return;
    List<Files> videoList =
        file.where((element) => element.fileExt == 'video/mp4' || element.fileExt == 'image/jpeg').toList();
    int count =
        videoList.fold(0, (previousValue, element) => previousValue + 1);
    playerController = List.generate(
        count,
        (index) => CachedVideoPlayerController.network(
            'https://www.batnf.net/${widget.singlePending.files![index].fileUrl}'
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
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: kBackground),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            //Project Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 10),
                  height: 350,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  // autoPlay: true
                ),
                items: widget.singlePending.files!.map((pendingFile) {
                if (pendingFile.fileExt == 'image/jpeg') {
                    return CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            Center(child: Text('No Image/Video Available')),
                        placeholder: (context, url) => Center(
                                child: Text(
                              'Loading',
                              style: TextStyle(color: Colors.black),
                            )),
                        imageUrl:
                            'https://www.batnf.net/${pendingFile.fileUrl}',
                        fit: BoxFit.cover);
                  }
                  CachedVideoPlayerController controller = playerController.firstWhere(
                      (element) =>
                          element.dataSource ==
                      'https://www.batnf.net/${pendingFile.fileUrl}'
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
                }).toList())
            ),
      
            //Project Title
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
              child: Text(
                widget.singlePending.projectTitle,
                style: kPageHeader,
              ),
            ),
      
            //Project Timeline
            Container(
              margin: EdgeInsets.only(left: 30, bottom: 21),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.calendarAlt,
                      size: 25,
                      color: kButtonColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'To Begin: ',
                              style: kLandpageskiptextstyle,
                              children: [
                            TextSpan(
                              text: widget.singlePending.projectStartDate,
                              style: kPageHeader,
                            )
                          ])),
                    ],
                  )
                ],
              ),
            ),
      
             //Project venue and location
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 15),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 22,
                      color: kButtonColor,
                    ),
                  ),
      
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        widget.singlePending.projectVenue,
                        style: kBodyTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.singlePending.projectLocation,
                        style: kBodyTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
      
            //Project description Header
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'About Project',
                style: kAboutTextStyle,
                textAlign: TextAlign.left,
              ),
            ),
      
            //Project Description
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
              child: Text(
                widget.singlePending.projectDescription,
                textAlign: TextAlign.justify,
                style: kBodyTextStyle,
              ),
            ),
          ],
        ),
      ),
     
      ));
  }
}