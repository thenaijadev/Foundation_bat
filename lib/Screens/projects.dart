// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'dart:io';

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/pending_project.dart';
import 'package:batnf/Screens/signin.dart';
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
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
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
        backgroundColor: kBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container for search box etc
            Container(
              height: 171,
              color: kBackground,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: kBackground,
                        height: 40.0,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 130),
                        color: kBackground,
                        height: 29,
                        child: Text('Projects', style: kPageHeader),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                    color: kBackground,
                    height: 45.0,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 2),
                        hintText: 'Search',
                        hintStyle: kTextboxhintstyle,
                        prefixIcon: Icon(
                          FontAwesomeIcons.search,
                          size: 13.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(45.0),
                            ),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: kTextfieldborderColor,
                              width: 2.0,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Project Body
            Expanded(
                child: ListView(
              children: [
                // Project Summary List Header
                Padding(
                  padding:
                      const EdgeInsets.only(top: 29.0, left: 30.0, bottom: 20),
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
                  height: 205,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Project in progress
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, InprogressPage.id);
                        },
                        child: ProjectSummaryContainer(
                          margin: EdgeInsets.only(left: 30, right: 41.5),
                          innercontainer: kBackground.withOpacity(0.1),
                          number: inprogressProvider
                                      .allInprogressProjects?.length ==
                                  null
                              ? 0
                              : inprogressProvider
                                  .allInprogressProjects!.length,
                          colour: Color(0xff0E2B63),
                          label: 'Projects in \nProgress',
                          childCard: Icon(
                            Icons.pie_chart_rounded,
                            size: 17.5,
                            color: kBackground,
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
                          innercontainer: kBackground.withOpacity(0.1),
                          number: completedProvider
                                      .allCompletedProjects?.length ==
                                  null
                              ? 0
                              : completedProvider.allCompletedProjects!.length,
                          colour: Color(0xff50AF47),
                          label: 'Projects \nCompleted',
                          childCard: Icon(
                            FontAwesomeIcons.checkSquare,
                            size: 17.5,
                            color: kBackground,
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
                          innercontainer: kBackground.withOpacity(0.1),
                          number:
                              pendingProvider.allPendingProjects?.length == null
                                  ? 0
                                  : pendingProvider.allPendingProjects!.length,
                          colour: Color(0xffEF7D00),
                          label: 'Pending \nProjects',
                          childCard: Icon(
                            FontAwesomeIcons.commentDots,
                            color: kBackground,
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
                            EdgeInsets.only(top: 15.0, left: 30.0, right: 30),

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
                                Navigator.pushNamed(context, InprogressPage.id);
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
                        child: inprogressProvider.allInprogressProjects == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : inprogressProvider.allInprogressProjects!.isEmpty
                                ? Center(
                                    child: Image.asset('assets/noitem.png.gif'),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: inprogressProvider
                                        .allInprogressProjects!.length,
                                    itemBuilder: ((context, index) {


                                      // Inprogress progress = inprogressProvider
                                      //     .allInprogressProjects![index];

                                      // Files files = inprogressProvider
                                      //     .allInprogressProjects![index]
                                      //     .projectfiles as Files;

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
                                          margin: EdgeInsets.only(
                                              bottom: 15.0,
                                              left: 30,
                                              right: 30),
                                          decoration: BoxDecoration(
                                            color: kBackground,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            boxShadow: [kBoxshadow],
                                          ),
                                          height: 104,
                                          child: Row(
                                            children: [
                                              // Inprogress Images
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 15,
                                                    left: 15,
                                                    bottom: 15.0,
                                                    right: 15.0),
                                                height: 74,
                                                width: 74,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                      imageUrl: inprogress.projectImage,
                                                      fit: BoxFit.cover),
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
                                                  color: kBackground,
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
                                                        inprogress.projectTitle,
                                                        style: kPageHeader,
                                                      ),
                                                      RichText(
                                                          text: TextSpan(
                                                              text: 'Started: ',
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
                                Navigator.pushNamed(context, CompletedPage.id);
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
                                    child: Image.asset('assets/noitem.png.gif'),
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
                                          margin: EdgeInsets.only(
                                              bottom: 15.0,
                                              left: 30,
                                              right: 30),
                                          decoration: BoxDecoration(
                                            color: kBackground,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            boxShadow: [kBoxshadow],
                                          ),
                                          height: 104,
                                          child: Row(
                                            children: [
                                              // Completed Image
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 15,
                                                    left: 15,
                                                    bottom: 15.0,
                                                    right: 15.0),
                                                height: 74,
                                                width: 74,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                      imageUrl: completed
                                                          .projectImage,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              // Completed Project Info
                                              Expanded(
                                                child: Container(
                                                  height: 93,
                                                  margin: EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 10,
                                                      right: 6.0),
                                                  color: kBackground,
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
                                                        completed.projectTitle,
                                                        style: kPageHeader,
                                                      ),
                                                      // project Start Date
                                                      RichText(
                                                          text: TextSpan(
                                                              text: 'Started: ',
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
                                      child: Image.asset('assets/noitem.png.gif'),
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
                                            height: 104,
                                            margin: EdgeInsets.only(
                                                bottom: 15.0,
                                                left: 30,
                                                right: 30),
                                            decoration: BoxDecoration(
                                              color: kBackground,
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
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                        imageUrl: pending
                                                            .projectImage,
                                                        fit: BoxFit.cover),
                                                  ),
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
                                      })))),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
