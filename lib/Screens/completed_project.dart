// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/completed_model.dart';
import '../providers/completed_provider.dart';

class CompletedPage extends StatefulWidget {
  static String id = 'completed';
  CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CompletedProvider>(context, listen: false)
        .getCompletedProjects();
  }
  @override
  Widget build(BuildContext context) {
    CompletedProvider provider = Provider.of<CompletedProvider>(context);
    return Scaffold(
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
              'Completed Projects',
              style: kSigningtextstyle,
            ),
          ),
          Expanded(
            child:  provider.allCompletedProjects == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : provider.allCompletedProjects!.isEmpty
                    ? Center(
                        child: Image.asset('assets/noitem.png.gif'),
                      )
                    : RefreshIndicator(
                        color: kBackground,
                        backgroundColor: kButtonColor,
                        onRefresh: () async {
                          await Provider.of<CompletedProvider>(context,
                                  listen: false)
                              .getCompletedProjects();
                        },
                      child: ListView.builder(
                          itemCount: provider.allCompletedProjects!.length,
                                  itemBuilder: ((context, index) {
                            CompletedModel completed =
                                provider.allCompletedProjects![index];
                                    return GestureDetector(
                                      onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CompletedProjectDetails(completed)));
                                      },
                                      child: Container(
                      margin: EdgeInsets.only(bottom: 15.0, left: 30, right: 30),
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
                                left: 15, bottom: 15.0, right: 15.0, top: 15),
                            height: 74,
                            width: 74,
                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                'https://www.batnf.net/${completed.projectImage}',
                                              fit: BoxFit.cover),
                                        ),
                          ),
                          Expanded(
                            child: Container(
                              height: 93,
                              margin: EdgeInsets.only(
                                  top: 5, bottom: 10, left: 10.0, right: 6.0),
                              color: kBackground,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Container(
                                    color: kBackground,
                                    height: 19,
                                    child: Text(
                                      completed.projectTitle,
                                      style: kNewsSubHeader,
                                    ),
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: 'Started: ',
                                          style: kLandpageskiptextstyle,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                        TextSpan(
                                          text: completed.projectStartDate,
                                          style: kTextboxhintstyle,
                                        )
                                      ])),
                                      RichText(
                                      text: TextSpan(
                                          text: 'Completed: ',
                                          style: kLandpageskiptextstyle,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                        TextSpan(
                                          text: completed.projectEndDate,
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
          ),
        ],
      ),
    
    );
  }
}
