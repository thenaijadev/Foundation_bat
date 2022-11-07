// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';

import '../Models/completed_model.dart';
import '../providers/completed_provider.dart';

class CompletedPage extends StatefulWidget {
  static String id = 'completed';
  CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<CompletedProvider>(context, listen: false)
  //       .getCompletedProjects();
  // }
  @override
  Widget build(BuildContext context) {
    CompletedProvider provider = Provider.of<CompletedProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Completed Projects',
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
            child: provider.allCompletedProjects == null
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompletedProjectDetails(
                                                completed)));
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
                                      child: completed.files!.first.fileUrl
                                                  .isEmpty &&
                                              completed.files!.first
                                                      .fileExt ==
                                                  'image/jpeg'
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
                                                      'https://www.batnf.net/${completed.files!.first.fileUrl}',
                                                  fit: BoxFit.cover),
                                            )
                                          : ClipRRect(
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
                                                      'https://www.batnf.net/${completed.files!.first.thumbnail}',
                                                  fit: BoxFit.cover),
                                            ),
                                    ),
                                    
                                    //Details
                                    Text(
                                      completed.projectTitle,
                                      style: kNewsSubHeader,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
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
    );
  }
}
