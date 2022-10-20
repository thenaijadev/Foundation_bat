// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/inprogress_provider.dart';

class ProgressDetails extends StatefulWidget {
  final InprogressModel singleProgress;
  ProgressDetails(this.singleProgress, {Key? key}) : super(key: key);

  @override
  _ProgressDetailsState createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  late CachedVideoPlayerController controller;
  @override
  void initState() {
   controller = CachedVideoPlayerController.network(
    'https://www.batnf.net/${widget.singleProgress.files![0].fileUrl}'
        // 'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
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
  }


  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
    final List<String> imgList = [
      'https://www.batnf.net/${widget.singleProgress.files![0].fileUrl}',
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
            width: MediaQuery.of(context).size.width,
            child:  widget.singleProgress.files![0].fileExt == 'video\/mp4'
                ? controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CachedVideoPlayer(controller))
                    : Center(child: const CircularProgressIndicator())
                :
            widget.singleProgress.files![0].fileUrl.isEmpty
                ? 
                CachedNetworkImage(
                    placeholder: (context, url) =>
                        Center(child: Text('Loading')),
                    imageUrl:
                        'https://www.batnf.net/${widget.singleProgress.projectImage}',
                    fit: BoxFit.cover)
                : Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 365,
                  )))
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leading: BackButton(
            color: kBackground,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<InprogressProvider>(context, listen: false)
                .getInprogressProjects();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Project Image
                SizedBox(
                  child: 

                  CarouselSlider(
                    options: CarouselOptions(
                        height: 350,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: true),
                    items: imageSliders,
                  ),
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
                                  text: widget.singleProgress.projectStartDate,
                                  style: kPageHeader,
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: 'To be Completed: ',
                                  style: kLandpageskiptextstyle,
                                  children: [
                                TextSpan(
                                  text: widget.singleProgress.projectEndDate,
                                  style: kPageHeader,
                                )
                              ])),
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
                          color: kButtonColor,
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
                    style: kBodyTextStyle,
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
      ),
    );
  }
}
