// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/pending_project.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/reuseable_project_summary_containers.dart';

class ProjectPage extends StatefulWidget {
  static String id = 'projects';
  ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // Container for search box etc
            Container(
              height: 171.0,
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
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 130),
                        color: kBackground,
                        height: 29,
                        child: Text(
                          'Projects',
                          style: kPageHeader,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 47,
                          bottom: 22,
                        ),
                        decoration: BoxDecoration(
                            color: kSignupbuttonColor.withOpacity(0.15),
                            shape: BoxShape.circle),
                        height: 36,
                        child: IconButton(
                          icon: Icon(
                              size: 15,
                              FontAwesomeIcons.signOutAlt,
                              color: kButtonColor),
                          onPressed: () {
                            Navigator.pushNamed(context, SignIn.id);
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                    color: kBackground,
                    height: 45.0,
                    child: TextField(
                      decoration: InputDecoration(
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Project Body
            Expanded(
              child: ListView(
                children: [
                  // Project Summary List Header
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 29.0, left: 30.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Projects Summary',
                          style: kPageHeader,
                        ),
                      ],
                    ),
                  ),

                  //Project Summary List
                  SizedBox(
                    height: 205,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        
                        //Projects In Progress
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, InprogressPage.id);
                          },
                          child: ProjectSummaryContainer(
                            margin: EdgeInsets.only(left: 30, right: 41.5),
                            innercontainer: kBackground.withOpacity(0.1),
                            Number: '3',
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
                            Number: '2',
                            colour: Color(0xff50AF47),
                            label: 'Projects \nCompleted',
                            childCard: Icon(
                              FontAwesomeIcons.checkSquare,
                              size: 17.5,
                              color: kBackground,
                            ),
                          ),
                        ),

                        //Pending project
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PendingPage.id);
                          },
                          child: ProjectSummaryContainer(
                            margin: EdgeInsets.only(right: 30),
                            innercontainer: kBackground.withOpacity(0.1),
                            Number: '2',
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

                  // In Progress label
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
                                'In Progress',
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProgressDetails()));
                            },
                            child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: 15.0, left: 30, right: 30),
                                    decoration: BoxDecoration(
                                      color: kBackground,
                                      borderRadius: BorderRadius.circular(18.0),
                                      boxShadow: [kBoxshadow],
                                    ),
                                    height: 104,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15,
                                              top: 15,
                                              bottom: 15.0,
                                              right: 15.0),
                                          height: 74,
                                          width: 74,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/projects.png'),
                                            ),
                                            color: kBackground,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
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
                                                    'Lorem Ipsum Project',
                                                    style: kNewsSubHeader,
                                                  ),
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'Start: ',
                                                        style:
                                                            kLandpageskiptextstyle,
                                                        children: [
                                                      TextSpan(
                                                          text: '2022-09-01',
                                                          style: kNewsDateSTyle)
                                                    ])),
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'To End: ',
                                                        style:
                                                            kLandpageskiptextstyle,
                                                        children: [
                                                      TextSpan(
                                                          text: '2022-09-40',
                                                          style: kNewsDateSTyle)
                                                    ])),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // In completeed label
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
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 3,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             CompletedProjectDetails()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  height: 104,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 15,
                                            left: 15,
                                            bottom: 15.0,
                                            right: 15.0),
                                        height: 74,
                                        width: 74,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/projects.png'),
                                          ),
                                          color: kBackground,
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
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
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Container(
                                                color: kBackground,
                                                height: 19,
                                                child: Text(
                                                  'Lorem Ipsum Project',
                                                  style: kPageHeader,
                                                ),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'Started: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                    TextSpan(
                                                      text: 'Dec 21 2021',
                                                      style: kTextboxhintstyle,
                                                    )
                                                  ])),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'Completed: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                    TextSpan(
                                                      text: 'Aug 13 2023',
                                                      style: kTextboxhintstyle,
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

                  // In Pending Progress label
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
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  height: 104,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 15,
                                            left: 15,
                                            bottom: 15.0,
                                            right: 15.0),
                                        height: 74,
                                        width: 74,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/projects.png'),
                                          ),
                                          color: kBackground,
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
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
                                                  'Lorem Ipsum Project',
                                                  style: kNewsSubHeader,
                                                ),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'To Begin: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                    TextSpan(
                                                      text: 'Mar 17 2025',
                                                      style: kTextboxhintstyle,
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
