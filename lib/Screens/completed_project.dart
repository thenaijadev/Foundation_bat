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
                                margin: EdgeInsets.only(
                                    left: 5, right: 5.0, bottom: 15.0, top: 30),
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
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            boxShadow: [kBoxshadow],
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 9.0, right: 9),
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
                                        Container(
                                           height: 100,
                                          margin: EdgeInsets.only(
                                              right: 6.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            boxShadow: [kBoxshadow],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text(
                                                completed.projectTitle,
                                                style: kNewsSubHeader,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  text: 'Started: ',
                                                style: kLandpageskiptextstyle,
                                                children: [
                                                    TextSpan(
                                                      text: completed
                                                          .projectStartDate,
                                                      style: kTextboxhintstyle,
                                                      
                                                    )
                                                  ]
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                ),
                                              
                                              Text.rich(
                                                  TextSpan(
                                                      text: 'Completed: ',
                                                      style:
                                                          kLandpageskiptextstyle,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                    TextSpan(
                                                      text: completed
                                                          .projectEndDate,
                                                      style: kTextboxhintstyle,
                                                    )
                                                  ]),
                                                   overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
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
    );
  }
}
