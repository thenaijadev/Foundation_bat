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
                                        children: [
                                          
                                          //Images
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              boxShadow: [kBoxshadow],
                                            ),
                                            // width:150,
                                            margin: EdgeInsets.only(
                                                left: 9.0, right: 9),
                                            child: pending
                                                    .files!.first.fileUrl.isEmpty && pending.files!.first.fileExt =='image/jpeg'
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(18),
                                                    child: CachedNetworkImage(
                                                       placeholder:
                                                            (context, url) =>
                                                                Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                        imageUrl:
                                                            'https://www.batnf.net/${pending.files!.first.fileUrl}',
                                                        fit: BoxFit.cover),
                                                  )
                                                 : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18),
                                                        child: CachedNetworkImage(
                                                             placeholder:
                                                            (context, url) =>
                                                                Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${pending.files!.first.thumbnail}',
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
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
                                                      style:
                                                          kLandpageskiptextstyle,
                                                    ),
                                                    Text(
                                                        pending
                                                            .projectStartDate,
                                                        style:
                                                            kTextboxhintstyle,
                                                            overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                            )
                                                  ],
                                                ),
                                               // To End Date
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'To End: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                    ),
                                                    Text(pending.projectEndDate,
                                                        style:
                                                            kTextboxhintstyle,
                                                            overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                                  ],
                                            ),
                                          ),

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
                                    
                                      ]
                                    ,
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
