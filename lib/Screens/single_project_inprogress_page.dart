// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/inprogress_provider.dart';

class ProgressDetails extends StatefulWidget {
  final InprogressModel singleProgress;
  ProgressDetails(this.singleProgress, {Key? key}) : super(key: key);

  @override
  _ProgressDetailsState createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  List<CachedVideoPlayerController> playerController = [];

  @override
  void initState() {
    video(widget.singleProgress.files!);
    super.initState();
  }

  void video(List<Files> file) async {
    if (file.isEmpty) return;
    List<Files> videoList = file
        .where((element) =>
            element.fileExt == 'video/mp4' && element.fileExt == 'image/jpeg')
        .toList();
    int count =
        videoList.fold(0, (previousValue, element) => previousValue + 1);
    playerController = List.generate(
        count,
        (index) => CachedVideoPlayerController.network(
            'https://www.batnf.net/${widget.singleProgress.files![index].fileUrl}'
            //  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            ));

    for (var element in playerController) {
      element.initialize().then((value) async {
        await Future.delayed(Duration(milliseconds: 500));
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
          leading: BackButton(
            color: kBackground,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Project Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                    options: CarouselOptions(
                      padEnds: false,
                      autoPlayInterval: Duration(seconds: 10),
                      height: 350,
                      viewportFraction: 0.98,
                      enableInfiniteScroll: false,
                      // autoPlay: true
                    ),
                    items: widget.singleProgress.files!.map((inprogressFile) {
                      print(inprogressFile.fileExt);
                      print(inprogressFile.fileUrl);
                      if (inprogressFile.fileExt == '') {
                        return Container(
                          color: kGeneralbodytextColor,
                          child: CachedNetworkImage(
                              imageUrl:
                                  'https://www.batnf.net/${inprogressFile.thumbnail}',
                              fit: BoxFit.cover),
                        );
                      } 
                      else
                       if (inprogressFile.fileExt == 'image/jpeg') {
                        return CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Center(child: Text('No Image Available')),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            imageUrl:
                                'https://www.batnf.net/${inprogressFile.fileUrl}',
                            fit: BoxFit.cover);
                      }
                      CachedVideoPlayerController controller =
                          playerController.firstWhere((element) =>
                              element.dataSource ==
                              'https://www.batnf.net/${inprogressFile.fileUrl}'
                              //  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                              );
                      return controller.value.isInitialized
                          ? Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                AspectRatio(
                                    aspectRatio:
                                        // 6 / 6,
                                        controller.value.aspectRatio,
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
                                    color: Colors.blue.withOpacity(0.5),
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
                          : CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogressFile.thumbnail}',
                                                        fit: BoxFit.cover);
                    }).toList()),
              ),

              //Project Title
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                child: Text(
                  widget.singleProgress.projectTitle,
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
                        color: kSignupbuttonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Container(
                          child: RichText(
                            selectionColor: Theme.of(context).primaryColor,
                              text: TextSpan(
                                  text: 'Started: ',
                                  style: kBodyTextStyle,
                                  children: [
                                TextSpan(                      
                                  text: widget.singleProgress.projectStartDate,
                                  style: kPageHeader,
                                )
                              ])),
                        ),
                        Container(
                          child: RichText(
                            selectionColor: Theme.of(context).primaryColor,
                              text: TextSpan(
                                  text: 'To be Completed: ',
                                  style: kBodyTextStyle,
                                  children: [
                                TextSpan(
                                  text: widget.singleProgress.projectEndDate,
                                  style: kPageHeader,
                                )
                              ])),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //Project Location and venue
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
                        color: kSignupbuttonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleProgress.projectVenue,
                          style: kPageHeader,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleProgress.projectLocation,
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
                  style: kAboutTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),

              //Project Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singleProgress.projectDescription,
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
