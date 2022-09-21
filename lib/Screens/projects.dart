// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/pending_project.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectPage extends StatefulWidget {
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: kBackground,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 142),
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
                              FontAwesomeIcons.solidBell,
                              size: 15,
                              color: kButtonColor),
                          onPressed: () {},
                        ),
                      ),
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
                // scrollDirection: Axis.vertical,
                children: [
                  // Project Summary List Header
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 29.0, left: 30.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Projects Summary',
                          style: kPageHeader,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 205,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [kBoxshadow],
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.only(left: 30, right: 41.5),
                          height: 250,
                          width: 198,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [kBoxshadow],
                            color: Colors.greenAccent,
                          ),
                          margin: EdgeInsets.only(right: 41.5),
                          height: 250,
                          width: 198,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [kBoxshadow],
                            color: Colors.orange,
                          ),
                          margin: EdgeInsets.only(right: 30),
                          height: 250,
                          width: 198,
                        ),
                      ],
                    ),
                  ),
    
                  // In Progress label
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 30),
                    height: 319,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'In Progress',
                              style: kPageHeader,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InprogressPage(),
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
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProgressDetails()));
                            },
                            child: ListView(
                              // padding: EdgeInsets.only(bottom: 15),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15.0),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 15.0, right: 15.0),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                AssetImage('assets/projects.png'),
                                          ),
                                          color: kBackground,
                                          borderRadius: BorderRadius.circular(18.0),
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
                                              Text(
                                                ' Started: Dec 21 2021',
                                                textAlign: TextAlign.left,
                                                style: kNewsDateSTyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  height: 120,
                                  width: 375,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 15.0, right: 15.0),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                AssetImage('assets/projects.png'),
                                          ),
                                          color: kBackground,
                                          borderRadius: BorderRadius.circular(18.0),
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
                                              Text(
                                                ' Started: Dec 21 2021',
                                                textAlign: TextAlign.left,
                                                style: kNewsDateSTyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
    
                  // In completeed label
                  Container(
                    margin: EdgeInsets.only(
                      top: 15.0,
                      left: 30.0,
                      right: 30,
                    ),
                    color: kBackground,
                    height: 319,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Completed',
                              style: kPageHeader,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompletedPage(),
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
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompletedProjectDetails()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15.0),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 15.0, right: 15.0),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                AssetImage('assets/projects.png'),
                                          ),
                                          color: kBackground,
                                          borderRadius: BorderRadius.circular(18.0),
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
                                              Text(
                                                ' Started: Dec 21 2021',
                                                textAlign: TextAlign.left,
                                                style: kNewsDateSTyle,
                                              )
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
                  Container(
                    margin: EdgeInsets.only(
                        top: 15.0, left: 30.0, right: 30, bottom: 15.0),
                    color: kBackground,
                    height: 319,
                    child: Column(
                      children: [
                        Row(
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
                        Expanded(
                          child: ListView(
                            // padding: EdgeInsets.only(bottom: 15),
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                  color: kBackground,
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: [kBoxshadow],
                                ),
                                height: 120,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 15.0, right: 15.0),
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('assets/projects.png'),
                                        ),
                                        color: kBackground,
                                        borderRadius: BorderRadius.circular(18.0),
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
                                            Text(
                                              ' Started: Dec 21 2021',
                                              textAlign: TextAlign.left,
                                              style: kNewsDateSTyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kBackground,
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: [kBoxshadow],
                                ),
                                height: 120,
                                width: 375,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 15.0, right: 15.0),
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('assets/projects.png'),
                                        ),
                                        color: kBackground,
                                        borderRadius: BorderRadius.circular(18.0),
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
                                            Text(
                                              ' Started: Dec 21 2021',
                                              textAlign: TextAlign.left,
                                              style: kNewsDateSTyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
