// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_pending_project_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/pending_model.dart';
import '../providers/pending_provider.dart';

class PendingPage extends StatefulWidget {
  static String id = 'pending';
  PendingPage({Key? key}) : super(key: key);

  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PendingProvider>(context, listen: false).getPendingProjects();
  }

  @override
  Widget build(BuildContext context) {
    PendingProvider provider = Provider.of<PendingProvider>(context);
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
                'Pending Projects',
                style: kSigningtextstyle,
              ),
            ),
            Expanded(
              child: provider.allPendingProjects == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allPendingProjects!.isEmpty
                      ? Center(
                          child: Text(
                            'No Completed Project, \nPlease check Your Internet Connection',
                            style: kBodyTextStyle,
                          ),
                        )
                      : RefreshIndicator(
                          color: kBackground,
                          backgroundColor: kButtonColor,
                          onRefresh: () async {
                            await Provider.of<PendingProvider>(context,
                                    listen: false)
                                .getPendingProjects();
                          },
                          child: ListView.builder(
                            itemCount: provider.allPendingProjects!.length,
                            itemBuilder: ((context, index) {
                              PendingModel pending =
                                  provider.allPendingProjects![index];
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
                                            bottom: 15.0,
                                            right: 15.0,
                                            top: 15),
                                        height: 74,
                                        width: 74,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: CachedNetworkImage(
                                              imageUrl: pending.projectImage,
                                              fit: BoxFit.cover),
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

                                              //Project Timelines
                                              Container(
                                                color: kBackground,
                                                height: 19,
                                                child: Text(
                                                  pending.projectTitle,
                                                  style: kPageHeader,
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
                                                      text: pending
                                                          .projectStartDate,
                                                      style: kTextboxhintstyle,
                                                    )
                                                  ])),
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'To End: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                    TextSpan(
                                                      text: pending
                                                          .projectEndDate,
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
      ),
    );
  }
}
