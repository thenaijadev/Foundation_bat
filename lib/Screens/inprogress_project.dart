// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/providers/inprogress_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_video_player/cached_video_player.dart';

class InprogressPage extends StatefulWidget {
  
  static String id = 'inprogress';
  InprogressPage( {Key? key}) : super(key: key);

  @override
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  late CachedVideoPlayerController controller;
  //  List<CachedVideoPlayerController> playerController = [];

  // VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();

    // video(Files);

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

  // void video(List<Files> file) async {
  //   if (file.isEmpty) return;
  //   List<Files> videoList =
  //       file.where((element) => element.fileExt == 'video/mp4').toList();
  //   int count =
  //       videoList.fold(0, (previousValue, element) => previousValue + 1);
  //   playerController = List.generate(
  //       count,
  //       (index) => CachedVideoPlayerController.network(
  //           'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
  //           // 'https://www.batnf.net/${inprogress.files![index].fileUrl}'
  //           // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
  //           ));

  //   for (var element in playerController) {
  //     element.initialize().then((value) async {
  //       await Future.delayed(Duration(milliseconds: 500));
  //       // element.play();
  //       setState(() {});
  //     });
  //   }
  // }

  @override
  void dispose() {
    // for (var element in playerController) {
    //   element.dispose();
    // }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Center(
            child: Text(
                  'Projects InProgress',
                  style: kSigningtextstyle,
                ),
          ),
          toolbarHeight: 94,
          backgroundColor: Theme.of(context).primaryColor,
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

            Expanded(
              child: provider.allInprogressProjects == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allInprogressProjects!.isEmpty
                      ? Center(child: Image.asset('assets/noitem.png.gif'))
                      : RefreshIndicator(
                          color: kBackground,
                          backgroundColor: Theme.of(context).primaryColor,
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
                                      left: 36.27, right: 15.0, bottom: 15.0, top: 30),
                                  // margin: EdgeInsets.only(
                                  //     bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  child: Column(
                                     crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [

                  //                     CarouselSlider(
                  // options: CarouselOptions(
                  //   padEnds: false,
                  //   autoPlayInterval: Duration(seconds: 10),
                  //   // height: 350,
                  //   height: 145,
                  //  aspectRatio: MediaQuery.of(context).size.width,
                  //   viewportFraction: 0.98,
                  //   enableInfiniteScroll: false,
                  //   // autoPlay: true
                  // ),
                  // items: inprogress.files!.map((inprogressFile) {
                  //   print(inprogressFile.fileExt);
                  //   print(inprogressFile.fileUrl);
                  //   if (inprogressFile.fileExt == '') {
                  //     return Container(
                  //       color: kGeneralbodytextColor,
                  //       child: CachedNetworkImage(
                  //           errorWidget: (context, url, error) => Center(
                  //                   child: Text(
                  //                 'No Image Available',
                  //                 style:
                  //                     TextStyle(color: kGeneralbodytextColor),
                  //               )),
                  //           placeholder: (context, url) =>
                  //               Center(child: CircularProgressIndicator()),
                  //           imageUrl:
                  //               'https://www.batnf.net/${inprogress.projectImage}',
                  //           fit: BoxFit.cover),
                  //     );
                  //   }
                  //   else if (inprogressFile.fileExt == 'image/jpeg') {
                  //     return CachedNetworkImage(
                  //         errorWidget: (context, url, error) =>
                  //             Center(child: Text('No Image Available')),
                  //         placeholder: (context, url) =>
                  //             Center(child: CircularProgressIndicator()),
                  //         imageUrl:
                  //             'https://www.batnf.net/${inprogressFile.fileUrl}',
                  //         fit: BoxFit.cover);
                  //   }
                  //   CachedVideoPlayerController controller =
                  //       playerController.firstWhere((element) =>
                  //           element.dataSource ==
                  //           // 'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
                  //           // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                  //           'https://www.batnf.net/${inprogressFile.fileUrl}');
                  //   return controller.value.isInitialized
                  //       ? Stack(
                  //           alignment: AlignmentDirectional.center,
                  //           children: [
                  //             AspectRatio(
                  //                 aspectRatio:
                  //                     // 6 / 6,
                  //                     controller.value.aspectRatio,
                  //                 child: CachedVideoPlayer(controller)),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 if (!controller.value.isInitialized) return;
                  //                 setState(
                  //                   () {
                  //                     controller.value.isPlaying
                  //                         ? controller.pause()
                  //                         : controller.play();
                  //                   },
                  //                 );
                  //               },
                  //               child: Icon(
                  //                 controller.value.isPlaying
                  //                     ? Icons.pause
                  //                     : Icons.play_arrow,
                  //                 color: Colors.blue.withOpacity(0.5),
                  //                 size: 30,
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       : Center(child: CircularProgressIndicator());
                  // }).toList()),

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
                                                            'https://www.batnf.net/${inprogress.files![index].thumbnail}',
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
