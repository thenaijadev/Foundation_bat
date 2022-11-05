// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/completed_model.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/files.dart';
import '../constants/color_constant.dart';



class CompletedProjectDetails extends StatefulWidget {
  final CompletedModel singleCompleted;
  CompletedProjectDetails(this.singleCompleted, {Key? key}) : super(key: key);

  @override
  _CompletedProjectDetailsState createState() =>
      _CompletedProjectDetailsState();
}

class _CompletedProjectDetailsState extends State<CompletedProjectDetails> {
  
  List<CachedVideoPlayerController> playerController = [];

   @override
  void initState() {
    super.initState();
    video(widget.singleCompleted.files!);
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
            // widget.singleCompleted.files![index].fileUrl
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
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              // Project Image
              SizedBox(
                child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 10),
                      height: 350,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      // autoPlay: true
                    ),
                    items: widget.singleCompleted.files!.map((completedFile) {
                      if (completedFile.fileExt == 'image/jpeg') {
                        return CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Center(child: Text('No Image/Video Available')),
                            placeholder: (context, url) => Center(
                                    child: Text(
                                  'Loading',
                                  style: TextStyle(color: Colors.black),
                                )),
                            imageUrl:
                                'https://www.batnf.net/${completedFile.fileUrl}',
                            fit: BoxFit.cover);
                      } else if (completedFile.thumbnail.isNotEmpty) {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                  child: Text('Loading...'),
                                ),
                            imageUrl:
                                'https://www.batnf.net/${completedFile.thumbnail}',
                            fit: BoxFit.cover);
                      }
                      CachedVideoPlayerController controller =
                          playerController.firstWhere((element) =>
                                  element.dataSource ==
                                  'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
                              // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                              // completedFile.fileUrl
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
              ),
          
              //Project Title
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                child: Text(
                  widget.singleCompleted.projectTitle,
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
                                text: 'Started: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singleCompleted.projectStartDate,
                                style: kPageHeader,
                              )
                            ])),
                            RichText(
                            text: TextSpan(
                                text: 'Completed: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singleCompleted.projectEndDate,
                                style: kPageHeader,
                              )
                            ])),
                      ],
                    )
                  ],
                ),
              ),
          
              //Project Location and Venue
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
                          widget.singleCompleted.projectVenue,
                          style: kBodyTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleCompleted.projectLocation,
                          style: kBodyTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
          
              //Project Description Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'About Project',
                  style: kBodyTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
          
              //Project Description
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singleCompleted.projectDescription,
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
