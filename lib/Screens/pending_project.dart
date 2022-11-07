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
                                  width: 368,
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30.0,
                                  ),
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 310,
                                        margin: EdgeInsets.only(
                                            bottom: 7.0, top: 7.0, left: 9.0),
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
                                      Text(
                                            pending.projectTitle,
                                            style: kPageHeader,
                                            overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                          ),
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
