// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

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
    // Provider.of<PendingProvider>(context, listen: false).getPendingProjects();
  }

  @override
  Widget build(BuildContext context) {
    PendingProvider provider = Provider.of<PendingProvider>(context);
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
              'Pending Projects',
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
              child: provider.allPendingProjects == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allPendingProjects!.isEmpty
                      ? Center(
                          child: Image.asset('assets/noitem.png.gif'),
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
                                  width: 237,
                                  margin: EdgeInsets.only(
                                      left: 36.27,
                                      right: 15.0,
                                      bottom: 15.0,
                                      top: 30),
                                  // margin: EdgeInsets.only(
                                  //     bottom: 15.0, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //Pending Images
                                      Container(
                                        height: 145,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: 9.0, right: 9),
                                        // margin: EdgeInsets.only(
                                        //     left: 15,
                                        //     bottom: 15.0,
                                        //     right: 15.0,
                                        //     top: 15),
                                        // height: 74,
                                        // width: 74,
                                        child: pending
                                                .files![0].fileUrl.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://www.batnf.net/${pending.files![index].thumbnail}',
                                                    fit: BoxFit.cover),
                                              )
                                            : pending.files![0].fileExt ==
                                                    'video\/mp4'
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${pending.files![0].fileUrl}',
                                                        fit: BoxFit.cover),
                                                    // _chewieVideoPlayer()
                                                    // controller!
                                                    //         .value.isInitialized
                                                    //     ? CachedVideoPlayer(
                                                    //         controller!)
                                                    // : CircularProgressIndicator(),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: CachedNetworkImage(
                                                      errorWidget: (context,
                                                                url, error) =>
                                                            CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://www.batnf.net/${pending.files![index].thumbnail}',
                                                              fit: BoxFit.fill,
                                                            ),
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                                  child: Text(
                                                                      'Loading...'),
                                                                ),
                                                        imageUrl:
                                                            'https://www.batnf.net/${pending.files![index].fileUrl}',
                                                        fit: BoxFit.cover),
                                                  ),
                                        // ClipRRect(
                                        //   borderRadius:
                                        //       BorderRadius.circular(18),
                                        //   child: CachedNetworkImage(
                                        //       imageUrl: 'https://www.batnf.net/${pending.projectImage}',
                                        //       fit: BoxFit.cover),
                                        // ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        pending.projectTitle,
                                        style: kPageHeader,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'To Begin: ',
                                            style: kLandpageskiptextstyle,
                                          ),
                                          Text(pending.projectStartDate,
                                              style: kTextboxhintstyle)
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
                                            style: kLandpageskiptextstyle,
                                          ),
                                          Text(pending.projectEndDate,
                                              style: kTextboxhintstyle)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
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
