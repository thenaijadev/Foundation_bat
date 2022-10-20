// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/providers/inprogress_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class InprogressPage extends StatefulWidget {
  
  static String id = 'inprogress';
  InprogressPage( {Key? key}) : super(key: key);

  @override
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  // InprogressProvider provider = Provider.of<InprogressProvider>(context);
  // InprogressModel inprogress = inprogress![0].files!.length;
  // final InprogressModel Progress;
  late CachedVideoPlayerController controller;

  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    controller = CachedVideoPlayerController.network(
        // 'https://www.batnf.net/${inprogress.files![0].fileUrl}'
        'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        );
    controller.initialize().then((value) {
      // controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 94,
          backgroundColor: kBackground,
          leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: kButtonColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProjectPage()));
                },
              )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 30, bottom: 50),
              child: Text(
                'Projects InProgress',
                style: kSigningtextstyle,
              ),
            ),
            Expanded(
              child: provider.allInprogressProjects == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allInprogressProjects!.isEmpty
                      ? Center(child: Image.asset('assets/noitem.png.gif'))
                      : RefreshIndicator(
                          color: kBackground,
                          backgroundColor: kButtonColor,
                          onRefresh: () async {
                            await Provider.of<InprogressProvider>(context,
                                    listen: false)
                                .getInprogressProjects();
                          },
                          child: ListView.builder(
                            itemCount: provider.allInprogressProjects!.length,
                            itemBuilder: ((context, index) {
                              InprogressModel inprogress =
                                  provider.allInprogressProjects![index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProgressDetails(inprogress)));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  // height: 104,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            bottom: 15.0,
                                            right: 15.0,
                                            top: 15),
                                        height: 74,
                                        width: 74,
                                        child: inprogress
                                                .files![0].fileUrl.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: CachedNetworkImage(
                                                  errorWidget: (context, url,
                                                            error) =>
                                                        Center(
                                                            child: Text(
                                                                'No Image Availaible')),
                                                    imageUrl:
                                                        'https://www.batnf.net/${inprogress.projectImage}',
                                                    fit: BoxFit.cover),
                                              )
                                            : inprogress.files![0].fileExt ==
                                                    'video\/mp4'
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: controller.value
                                                            .isInitialized
                                                        ? AspectRatio(
                                                            aspectRatio:
                                                                controller
                                                                    .value
                                                                    .aspectRatio,
                                                            child: CachedVideoPlayer(
                                                                controller))
                                                        : Center(child: const CircularProgressIndicator()),
                                                    // CachedNetworkImage(
                                                    //     imageUrl:
                                                    //         'https://www.batnf.net/${inprogress.files![0].fileUrl}',
                                                    //     fit: BoxFit.cover),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.files![0].fileUrl}',
                                                        fit: BoxFit.cover),
                                                  ),
                                      ),

                                      //Details
                                      Expanded(
                                        child: Container(
                                          height: 93,
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 10,
                                              left: 10.0,
                                              right: 6.0),
                                          color: kBackground,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Container(
                                                color: kBackground,
                                                height: 19,
                                                child: Text(
                                                  // inprogress.projectfiles![index].fileUrl,
                                                  inprogress.projectTitle,
                                                  style: kNewsSubHeader,
                                                ),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'Started: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      children: [
                                                    TextSpan(
                                                        text: inprogress
                                                            .projectStartDate,
                                                        style: kNewsDateSTyle)
                                                  ])),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'To End: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      children: [
                                                    TextSpan(
                                                        text: inprogress
                                                            .projectEndDate,
                                                        style: kNewsDateSTyle)
                                                  ])),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _chewieVideoPlayer() {
  //   return _chewieController != null && _videoPlayerController != null
  //       ? Container(
  //           child: Chewie(controller: _chewieController!),
  //         )
  //       : const CircularProgressIndicator();
  // }
}
