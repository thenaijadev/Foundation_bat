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
class InprogressPage extends StatefulWidget {
  static String id = 'inprogress';
  InprogressPage({Key? key}) : super(key: key);

  @override
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Projects InProgress',
              style: kSigningtextstyle,
            ),
          ),
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
                              print(inprogress.files![index].thumbnail);

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
                                      left: 5,
                                      right: 5.0,
                                      bottom: 15.0,
                                      top: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //Images and videos
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 9.0, right: 9),
                                            child: inprogress.files![index]
                                                            .fileExt ==
                                                        'image/jpeg' &&
                                                    inprogress.files![index].fileUrl
                                                        .isNotEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.files![index].fileUrl}',
                                                        fit: BoxFit.cover),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.files![index].thumbnail}',
                                                        fit: BoxFit.cover),
                                                  ),
                                          ),

                                          //Details
                                          Container(
                                            height: 100,
                                            margin: EdgeInsets.only(
                                                // top: 5,
                                                left: 10.0,
                                                right: 6.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            child: Column(
                                              children: [
                                                 Text(
                                                  inprogress.projectTitle,
                                                  style: kNewsSubHeader,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Started: ',
                                                      style: kNewsDateSTyle,
                                                    ),
                                                    Text(
                                                        inprogress
                                                            .projectStartDate,
                                                        style: kNewsDateSTyle)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'To End: ',
                                                      style: kNewsDateSTyle,
                                                    ),
                                                    Text(
                                                        inprogress
                                                            .projectEndDate,
                                                        style: kNewsDateSTyle)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                         
                                        ],
                                      ),
                                     SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '.............................',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 30),
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
