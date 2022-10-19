// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;
  // @override
  // void initState() {
  //   _videoPlayerController = VideoPlayerController.asset(
  //     // 'assets/movie.mp4'
  //       'https://youtu.be/-LPe4tYckkg?t=3'
  //       // 'www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
  //       );
  //   _videoPlayerController!.initialize().then((_) {
  //     _chewieController =
  //         ChewieController(videoPlayerController: _videoPlayerController!);
  //     _videoPlayerController!.play();
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _videoPlayerController!.dispose();
  //   _chewieController!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
     final List<String> imgList = [
      'https://www.batnf.net/${widget.singleProgress.files![0].fileUrl}',
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              width: MediaQuery.of(context).size.width,
              child: widget.singleProgress.files![0].fileUrl.isEmpty
                  ? CachedNetworkImage(
                      placeholder: (context, url) =>
                          Center(child: Text('Loading')),
                      imageUrl:
                          'https://www.batnf.net/${widget.singleProgress.projectImage}',
                      fit: BoxFit.cover)
                  : Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 365,
                    ),
            ))
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
                    child: CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: true),
                    items: imageSliders,
                  ),
                    // ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount:
                    //         provider.allInprogressProjects![0].files!.length,
                    //     itemBuilder: ((context, index) {
                    //       return Container(
                    //           width: 335,
                    //           // MediaQuery.of(context).size.width,
                    //           color: kBackground,
                    //           child: provider.allInprogressProjects![0]
                    //                       .files![1].fileExt ==
                    //                   'video/mp4'
                    //               ? ClipRRect(
                    //                   borderRadius: BorderRadius.circular(18),
                    //                   child: _chewieVideoPlayer()
                    //                   // controller!
                    //                   //         .value.isInitialized
                    //                   //     ? CachedVideoPlayer(
                    //                   //         controller!)
                    //                   // : CircularProgressIndicator(),
                    //                   )
                    //               :provider
                    //                                 .allInprogressProjects![
                    //                                     0]
                    //                                 .files![index]
                    //                                 .fileExt
                    //                                 .isEmpty 
                    //                             ? ClipRRect(
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         18),
                    //                                 child: CachedNetworkImage(
                    //                                     imageUrl:
                    //                                         'https://www.batnf.net/${widget.singleProgress.projectImage}',
                    //                                     fit: BoxFit.cover),
                    //                               )
                    //                             :
                    //           // _videoPlayerController!.value.isInitialized
                    //           // ? VideoPlayer(_videoPlayerController!) : Center(child: CircularProgressIndicator()));
                    //           // _chewieVideoPlayer());
                    //         CachedNetworkImage(
                    //             errorWidget: (context, url, error) =>
                    //                 CachedNetworkImage(
                    //                     imageUrl:
                    //                         'https://www.batnf.net/${widget.singleProgress.projectImage}',
                    //                     fit: BoxFit.cover),
                    //             // placeholder: (context, url) => CachedNetworkImage(
                    //             //     imageUrl:
                    //             //         'https://www.batnf.net/${widget.singleProgress.projectImage}'),
                    //             imageUrl:
                    //                 'https://www.batnf.net/${widget.singleProgress.files![index].fileUrl}',
                    //             fit: BoxFit.cover),
                    //       );
                    //     }))
                    
                    // ),
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

  // Widget _chewieVideoPlayer() {
  //   return _chewieController != null && _videoPlayerController != null
  //       ? Container(
  //           width: 335,
  //           child: Chewie(controller: _chewieController!),
  //         )
  //       : Center(child: const CircularProgressIndicator());
  // }
}
