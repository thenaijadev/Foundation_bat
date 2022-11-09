// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<PendingProvider>(context, listen: false).getPendingProjects();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    Provider.of<CompletedProvider>(context, listen: false)
        .getCompletedProjects();
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
        // backgroundColor: Theme.of(context).primaryColor,
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
                ],
              ),
            ),

            //Project Body
            Expanded(
              child: ListView(
                children: [
                  // // Project Summary List Header
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 29.0, left: 30.0, bottom: 20),
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Projects Summary',
                  //         style: kPageHeader,
                  //       )
                  //     ],
                  //   ),
                  // ),

                  //Project Summary List

                  // SizedBox(
                  //   height: 150,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       //Project in progress
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.pushNamed(context, InprogressPage.id);
                  //         },
                  //         child: ProjectSummaryContainer(
                  //           margin: EdgeInsets.only(left: 30, right: 60.5),
                  //           innercontainer: Theme.of(context).primaryColor
                  //               .withOpacity(0.1),
                  //           number: inprogressProvider
                  //                       .allInprogressProjects?.length ==
                  //                   null
                  //               ? 0
                  //               : inprogressProvider
                  //                   .allInprogressProjects!.length,
                  //           colour: Theme.of(context).primaryColor,
                  //           label: 'InProgress',
                  //           childCard: Icon(
                  //             FontAwesomeIcons.spinner,
                  //             size: 65,
                  //             color: Colors.yellow,
                  //           ),
                  //         ),
                  //       ),

                  //       //Completed Project
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.pushNamed(context, CompletedPage.id);
                  //         },
                  //         child: ProjectSummaryContainer(
                  //           margin: EdgeInsets.only(right: 41.5),
                  //           innercontainer: Theme.of(context).primaryColor.withOpacity(0.1),
                  //           number: completedProvider
                  //                       .allCompletedProjects?.length ==
                  //                   null
                  //               ? 0
                  //               : completedProvider
                  //                   .allCompletedProjects!.length,
                  //           colour: Color(0xff50AF47),
                  //           label: 'Completed',
                  //           childCard: Icon(
                  //             FontAwesomeIcons.checkCircle,
                  //             size: 65,
                  //             color: Color(0xff50AF47),
                  //           ),
                  //         ),
                  //       ),

                  //       // Pending project
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.pushNamed(context, PendingPage.id);
                  //         },
                  //         child: ProjectSummaryContainer(
                  //           margin: EdgeInsets.only(right: 30),
                  //           innercontainer: Theme.of(context).primaryColor.withOpacity(0.1),
                  //           number: pendingProvider
                  //                       .allPendingProjects?.length ==
                  //                   null
                  //               ? 0
                  //               : pendingProvider.allPendingProjects!.length,
                  //           colour: Color(0xffEF7D00),
                  //           label: 'Pending',
                  //           childCard: Icon(
                  //             FontAwesomeIcons.solidCommentDots,
                  //             color: Color(0xffEF7D00),
                  //             size: 65,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //Inprogress Project
                  SizedBox(
                    height: 150,
                    width: 365,
                    child: Column(
                      children: [
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
                                            // Navigator.pushNamed(
                                            //     context, InprogressPage.id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProgressDetails(
                                                            inprogress)));
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            // width: 375,
                                            child: Row(
                                              children: [
                                                // Inprogress Images
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 15.0),
                                                  height: 100,
                                                  width: 180,
                                                  child: inprogress.files!.first
                                                                  .fileExt ==
                                                              'image/jpeg' &&
                                                          inprogress
                                                              .files!
                                                              .first
                                                              .fileUrl
                                                              .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${inprogress.files!.first.fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${inprogress.files!.first.thumbnail}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),
                                                ),

                                                // Inprogress Information
                                                Container(
                                                  width: 180,
                                                  height: 100,
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Text(
                                                        inprogress.projectTitle,
                                                        style: kNewsSubHeader,
                                                      ),
                                                      Text.rich(
                                                          textAlign:
                                                              TextAlign.justify,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          TextSpan(
                                                              text: 'Title: ',
                                                              style:
                                                                  kNewsSubHeader,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                TextSpan(
                                                                  style:
                                                                      kNewsDateSTyle,
                                                                  text: inprogress
                                                                      .projectDescription,
                                                                )
                                                              ])),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Status: ',
                                                            style:
                                                                kNewsSubHeader,
                                                          ),
                                                          Text(
                                                            inprogress
                                                                .projectStatus,
                                                            style:
                                                                kNewsSubHeader,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          )
                                                        ],
                                                      ),
                                                    ],
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
                    height: 150,
                    width: 365,
                    child: Column(
                      children: [
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
                                      scrollDirection: Axis.horizontal,
                                      itemCount: completedProvider
                                          .allCompletedProjects!.length,
                                      itemBuilder: ((context, index) {
                                        CompletedModel completed =
                                            completedProvider
                                                .allCompletedProjects![index];
                                        return GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, CompletedPage.id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompletedProjectDetails(
                                                            completed)));
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            // width: 375,
                                            child: Row(
                                              children: [
                                                // Completed Image
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 15.0),
                                                  height: 100,
                                                  width: 180,
                                                  child: completed.files!.first
                                                                  .fileExt ==
                                                              'image/jpeg' &&
                                                          completed
                                                              .files!
                                                              .first
                                                              .fileUrl
                                                              .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${completed.files!.first.fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${completed.files!.first.thumbnail}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),
                                                ),

                                                // Completed Project Info
                                                Container(
                                                  width: 180,
                                                  height: 100,
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      // Project Title
                                                      Text(
                                                        completed.projectTitle,
                                                        style: kNewsSubHeader,
                                                      ),
                                                      // project Start Date
                                                      Text.rich(
                                                          textAlign:
                                                              TextAlign.justify,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          TextSpan(
                                                              text: 'Title: ',
                                                              style:
                                                                  kNewsSubHeader,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                TextSpan(
                                                                  text: completed
                                                                      .projectDescription,
                                                                  style:
                                                                      kNewsDateSTyle,
                                                                )
                                                              ])),

                                                      //Project Status
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'Status: ',
                                                          style: kNewsSubHeader,
                                                          // ignore: prefer_const_literals_to_create_immutables
                                                          children: [
                                                            TextSpan(
                                                              text: completed
                                                                  .projectStatus,
                                                              style:
                                                                  kNewsDateSTyle,
                                                            )
                                                          ])),
                                                    ],
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
                    height: 150,
                    width: 365,
                    child: Column(
                      children: [
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
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pendingProvider
                                          .allPendingProjects!.length,
                                      itemBuilder: (((context, index) {
                                        PendingModel pending = pendingProvider
                                            .allPendingProjects![index];
                                        return GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, PendingPage.id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PendingDetails(
                                                            pending)));
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                //pending Project Image
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 15.0),
                                                  height: 100,
                                                  width: 180,
                                                  child: pending.files!.first
                                                                  .fileExt ==
                                                              'image/jpeg' &&
                                                          pending
                                                              .files!
                                                              .first
                                                              .fileUrl
                                                              .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${pending.files!.first.fileUrl}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child:
                                                              CachedNetworkImage(
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Loading',
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                  imageUrl:
                                                                      'https://www.batnf.net/${pending.files!.first.thumbnail}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),
                                                ),

                                                //Pending Project Details
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  width: 180,
                                                  height: 100,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      //Project Title
                                                      Text(pending.projectTitle,
                                                          style:
                                                              kNewsSubHeader),

                                                      //Project Begin Date
                                                      Text.rich(
                                                          textAlign:
                                                              TextAlign.justify,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          TextSpan(
                                                              text: 'Title: ',
                                                              style:
                                                                  kNewsSubHeader,
                                                              children: [
                                                                TextSpan(
                                                                  text: pending
                                                                      .projectDescription,
                                                                  style:
                                                                      kNewsDateSTyle,
                                                                ),
                                                              ])),
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'Status: ',
                                                          style: kNewsSubHeader,
                                                          children: [
                                                            TextSpan(
                                                              text: pending
                                                                  .projectStatus,
                                                              style:
                                                                  kNewsDateSTyle,
                                                            ),
                                                          ])
                                                          ),
                                                    ],
                                                  ),
                                                )
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
