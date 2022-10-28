// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/pending_project.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/Screens/single_pending_project_page.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';

import '../Models/completed_model.dart';
import '../Models/inprogress_model.dart';
import '../Models/pending_model.dart';
import '../providers/completed_provider.dart';
import '../providers/inprogress_provider.dart';
import '../providers/pending_provider.dart';
import '../widgets/reuseable_project_summary_containers.dart';

class ProjectPage extends StatefulWidget {
  static String id = 'projects';
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late CachedVideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    Provider.of<PendingProvider>(context, listen: false).getPendingProjects();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    Provider.of<CompletedProvider>(context, listen: false)
        .getCompletedProjects();
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
    CompletedProvider completedProvider =
        Provider.of<CompletedProvider>(context);
    PendingProvider pendingProvider = Provider.of<PendingProvider>(context);
    InprogressProvider inprogressProvider =
        Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container for search box etc
            Container(
              // height: 171,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: Theme.of(context).primaryColor,
                        height: 40.0,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 130),
                        color: Theme.of(context).primaryColor,
                        height: 29,
                        child: Text('Projects', style: kPageHeader),
                      ),
                    ],
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                  //   color: kBackground,
                  //   height: 45.0,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(top: 2),
                  //       hintText: 'Search',
                  //       hintStyle: kTextboxhintstyle,
                  //       prefixIcon: Icon(
                  //         FontAwesomeIcons.search,
                  //         size: 13.0,
                  //       ),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(45.0),
                  //           ),
                  //           borderSide: BorderSide(
                  //             style: BorderStyle.solid,
                  //             color: kTextfieldborderColor,
                  //             width: 2.0,
                  //           )),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            //Project Body
            Expanded(
              child: ListView(
                children: [
                  // Project Summary List Header
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 29.0, left: 30.0, bottom: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Projects Summary',
                          style: kPageHeader,
                        )
                      ],
                    ),
                  ),

                  //Project Summary List

                  SizedBox(
                    // color: kSignupbuttonColor,
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        //Project in progress
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, InprogressPage.id);
                          },
                          child: ProjectSummaryContainer(
                            margin: EdgeInsets.only(left: 30, right: 60.5),
                            innercontainer: Theme.of(context).primaryColor
                                .withOpacity(0.1),
                            number: inprogressProvider
                                        .allInprogressProjects?.length ==
                                    null
                                ? 0
                                : inprogressProvider
                                    .allInprogressProjects!.length,
                            colour: Theme.of(context).primaryColor,
                            label: 'InProgress',
                            childCard: Icon(
                              FontAwesomeIcons.spinner,
                              size: 65,
                              color: Colors.yellow,
                            ),
                          ),
                        ),

                        //Completed Project
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CompletedPage.id);
                          },
                          child: ProjectSummaryContainer(
                            margin: EdgeInsets.only(right: 41.5),
                            innercontainer: Theme.of(context).primaryColor.withOpacity(0.1),
                            number: completedProvider
                                        .allCompletedProjects?.length ==
                                    null
                                ? 0
                                : completedProvider
                                    .allCompletedProjects!.length,
                            colour: Color(0xff50AF47),
                            label: 'Projects \nCompleted',
                            childCard: Icon(
                              FontAwesomeIcons.checkCircle,
                              size: 65,
                              color: Color(0xff50AF47),
                            ),
                          ),
                        ),

                        // Pending project
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PendingPage.id);
                          },
                          child: ProjectSummaryContainer(
                            margin: EdgeInsets.only(right: 30),
                            innercontainer: Theme.of(context).primaryColor.withOpacity(0.1),
                            number: pendingProvider
                                        .allPendingProjects?.length ==
                                    null
                                ? 0
                                : pendingProvider.allPendingProjects!.length,
                            colour: Color(0xffEF7D00),
                            label: 'Pending \nProjects',
                            childCard: Icon(
                              FontAwesomeIcons.solidCommentDots,
                              color: Color(0xffEF7D00),
                              size: 65,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Inprogress Project
                  SizedBox(
                    height: 319,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 5.0, left: 30.0, right: 30),

                          //Label
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Inprogress',
                                style: kPageHeader,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, InprogressPage.id);
                                },
                                child: Text(
                                  'See All',
                                  style: kForgetpasswordstyle,
                                ),
                              )
                            ],
                          ),
                        ),

                        // Inprogress Details
                        Expanded(
                          child: inprogressProvider.allInprogressProjects ==
                                  null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : inprogressProvider
                                      .allInprogressProjects!.isEmpty
                                  ? Center(
                                      child:
                                          Image.asset('assets/noitem.png.gif'),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: inprogressProvider
                                          .allInprogressProjects!.length,
                                      itemBuilder: ((context, index) {
                                        InprogressModel inprogress =
                                            inprogressProvider
                                                .allInprogressProjects![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProgressDetails(
                                                            inprogress)));
                                          },
                                          child: Container(
                                             width: 237,
                                            margin: EdgeInsets.only(
                                                left: 36.27,
                                                right: 15.0,
                                                bottom: 15.0,
                                                top: 30),

                                            // margin: EdgeInsets.only(
                                            //     bottom: 15.0,
                                            //     left: 30,
                                            //     right: 30),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Inprogress Images
                                                Container(
                                                   height: 145,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.only(
                                                      left: 9.0, right: 9),
                                                  // margin: EdgeInsets.only(
                                                  //     top: 15,
                                                  //     left: 15,
                                                  //     bottom: 15.0,
                                                  //     right: 15.0),
                                                  // // height: 74,
                                                  // width: 74,
                                                  child: inprogress.files![0]
                                                          .fileUrl.isEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://www.batnf.net/${inprogress.projectImage}',
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : inprogress.files![0]
                                                                  .fileExt ==
                                                              'video/mp4'
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: controller
                                                                      .value
                                                                      .isInitialized
                                                                  ? AspectRatio(
                                                                      aspectRatio: controller
                                                                          .value
                                                                          .aspectRatio,
                                                                      child: CachedVideoPlayer(
                                                                          controller))
                                                                  : Center(
                                                                      child:
                                                                          const CircularProgressIndicator()),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${inprogress.files![0].fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                ),

                                                // Inprogress Information
                                                Expanded(
                                                  child: Container(
                                                    height: 93,
                                                    margin: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 5,
                                                        right: 6.0),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        Text(
                                                          inprogress
                                                              .projectTitle,
                                                          style: kPageHeader,
                                                        ),
                                                        RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    'Started: ',
                                                                style:
                                                                    kLandpageskiptextstyle,
                                                                // ignore: prefer_const_literals_to_create_immutables
                                                                children: [
                                                              TextSpan(
                                                                text: inprogress
                                                                    .projectStartDate,
                                                                style:
                                                                    kTextboxhintstyle,
                                                              )
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
                      ],
                    ),
                  ),

                  //Completed Project
                  SizedBox(
                    height: 319,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 15.0, left: 30.0, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Completed',
                                style: kPageHeader,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, CompletedPage.id);
                                },
                                child: Text(
                                  'See All',
                                  style: kForgetpasswordstyle,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: completedProvider.allCompletedProjects == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : completedProvider.allCompletedProjects!.isEmpty
                                  ? Center(
                                      child:
                                          Image.asset('assets/noitem.png.gif'),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: completedProvider
                                          .allCompletedProjects!.length,
                                      itemBuilder: ((context, index) {
                                        CompletedModel completed =
                                            completedProvider
                                                .allCompletedProjects![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompletedProjectDetails(
                                                            completed)));
                                          },
                                          child: Container(
                                             width: 237,
                                            margin: EdgeInsets.only(
                                                left: 36.27,
                                                right: 15.0,
                                                bottom: 15.0,
                                                top: 30),
                                            // margin: EdgeInsets.only(
                                            //     bottom: 15.0,
                                            //     left: 30,
                                            //     right: 30),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            // height: 104,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Completed Image
                                                Container(
                                                  
                                                  height: 145,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.only(
                                                      left: 9.0, right: 9),
                                                  // margin: EdgeInsets.only(
                                                  //     top: 15,
                                                  //     left: 15,
                                                  //     bottom: 15.0,
                                                  //     right: 15.0),
                                                  // height: 74,
                                                  // width: 74,
                                                  child: completed.files![index]
                                                          .fileUrl.isEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://www.batnf.net/${completed.projectImage}',
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : completed.files![index]
                                                                  .fileExt ==
                                                              'video\/mp4'
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${completed.files![0].fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                              // _chewieVideoPlayer()
                                                              // controller!
                                                              //         .value.isInitialized
                                                              //     ? CachedVideoPlayer(
                                                              //         controller!)
                                                              // : CircularProgressIndicator(),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${completed.files![index].fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(18),
                                                  //   child: CachedNetworkImage(
                                                  //       imageUrl: 'https://www.batnf.net/${completed.projectImage}',
                                                  //       fit: BoxFit.cover),
                                                  // ),
                                                ),
                                                // Completed Project Info
                                                Expanded(
                                                  child: Container(
                                                    height: 93,
                                                    margin: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 10,
                                                        right: 6.0),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        // Project Title
                                                        Text(
                                                          completed
                                                              .projectTitle,
                                                          style: kPageHeader,
                                                        ),
                                                        // project Start Date
                                                        RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    'Started: ',
                                                                style:
                                                                    kLandpageskiptextstyle,
                                                                // ignore: prefer_const_literals_to_create_immutables
                                                                children: [
                                                              TextSpan(
                                                                text: completed
                                                                    .projectStartDate,
                                                                style:
                                                                    kTextboxhintstyle,
                                                              )
                                                            ])),

                                                        //Project Completed date
                                                        RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    'Completed: ',
                                                                style:
                                                                    kLandpageskiptextstyle,
                                                                // ignore: prefer_const_literals_to_create_immutables
                                                                children: [
                                                              TextSpan(
                                                                text: completed
                                                                    .projectEndDate,
                                                                style:
                                                                    kTextboxhintstyle,
                                                              )
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
                      ],
                    ),
                  ),

                  // Pending Progress label
                  SizedBox(
                    height: 319,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 15.0, left: 30.0, right: 30, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pending',
                                style: kPageHeader,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PendingPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'See All',
                                  style: kForgetpasswordstyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: pendingProvider.allPendingProjects == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : pendingProvider.allPendingProjects!.isEmpty
                                  ? Center(
                                      child:
                                          Image.asset('assets/noitem.png.gif'),
                                    )
                                  : ListView.builder(
                                      itemCount: pendingProvider
                                          .allPendingProjects!.length,
                                      itemBuilder: (((context, index) {
                                        PendingModel pending = pendingProvider
                                            .allPendingProjects![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PendingDetails(
                                                            pending)));
                                          },
                                          child: Container(
                                            // height: 104,
                                            margin: EdgeInsets.only(
                                                bottom: 15.0,
                                                left: 30,
                                                right: 30),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            child: Row(
                                              children: [
                                                //pending Project Image
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 15,
                                                      left: 15,
                                                      bottom: 15.0,
                                                      right: 15.0),
                                                  height: 74,
                                                  width: 74,
                                                  child: pending.files![0]
                                                          .fileUrl.isEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://www.batnf.net/${pending.projectImage}',
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : pending.files![0]
                                                                  .fileExt ==
                                                              'video\/mp4'
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${pending.files![0].fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                              // _chewieVideoPlayer()
                                                              // controller!
                                                              //         .value.isInitialized
                                                              //     ? CachedVideoPlayer(
                                                              //         controller!)
                                                              // : CircularProgressIndicator(),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${pending.files![index].fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           10),
                                                  //   child: CachedNetworkImage(
                                                  //       imageUrl: 'https://www.batnf.net/${pending.projectImage}',
                                                  //       fit: BoxFit.cover),
                                                  // ),
                                                ),

                                                //Pending Project Details
                                                Expanded(
                                                    child: Container(
                                                  height: 93,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 6.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      //Project Title
                                                      Text(pending.projectTitle,
                                                          style:
                                                              kNewsSubHeader),

                                                      //Project Begin Date
                                                      RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  'To Begin: ',
                                                              style:
                                                                  kLandpageskiptextstyle,
                                                              children: [
                                                            TextSpan(
                                                              text: pending
                                                                  .projectStartDate,
                                                              style:
                                                                  kTextboxhintstyle,
                                                            ),
                                                          ]))
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                                    ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
       
      ),
    );
  }
}
