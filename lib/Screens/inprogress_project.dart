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
  late CachedVideoPlayerController controller;

  // VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    controller = CachedVideoPlayerController.network(
        // 'https://www.batnf.net/${inprogress.files![0].fileUrl}'
        // 'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
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
        backgroundColor: kBackground,
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
                                  // height: 202,
                                  width: 237,
                                  margin: EdgeInsets.only(
                                      left: 36.27, right: 15.0, bottom: 15.0, top: 10),
                                  // margin: EdgeInsets.only(
                                  //     bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: kTextboxhintColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  child: Column(
                                     crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 145,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: 9.0, right: 9),
                                        // margin: EdgeInsets.only(
                                        //     left: 15,
                                        //     bottom: 15.0,
                                        //     right: 15.0,
                                        //     top: 15),
                                        // height: 74,
                                        // width: 74,
                                        child: inprogress
                                                .files![0].fileUrl.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.projectImage}',
                                                        fit: BoxFit.cover),
                                              )
                                            : inprogress.files![0].fileExt ==
                                                    'video/mp4'
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
                                      
                                      SizedBox(
                                        height: 8,
                                      ),
                                      //Details
                                      Text(
                                        // inprogress.projectfiles![index].fileUrl,
                                        inprogress.projectTitle,
                                        style: kNewsSubHeader,
                                      ),
                                      SizedBox(height: 8,),
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

                                      SizedBox(
                                        height: 8,
                                      ),
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
                                          ]))
                                    
                                      ,SizedBox(height: 8,),
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
