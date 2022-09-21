// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/completed_model.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/color_constant.dart';
import '../providers/completed_provider.dart';

class CompletedProjectDetails extends StatefulWidget {
  final CompletedModel singleCompleted;
  CompletedProjectDetails(this.singleCompleted, {Key? key}) : super(key: key);

  @override
  _CompletedProjectDetailsState createState() =>
      _CompletedProjectDetailsState();
}

class _CompletedProjectDetailsState extends State<CompletedProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<CompletedProvider>(context, listen: false)
                .getCompletedProjects();
          },
          child: ListView(
            children: [

              // Project Image
              SizedBox(
                height: 265,
                child: CachedNetworkImage(
                  imageUrl: widget.singleCompleted.projectImage,
                  fit: BoxFit.cover,
                ),
              ),

              //Project Title
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                child: Text(
                  widget.singleCompleted.projectTitle,
                  style: kPageHeader,
                ),
              ),

              //Project Timeline
              Container(
                margin: EdgeInsets.only(left: 30, bottom: 21),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kButtonColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        FontAwesomeIcons.calendarAlt,
                        size: 25,
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Started: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singleCompleted.projectStartDate,
                                style: kPageHeader,
                              )
                            ])),
                            RichText(
                            text: TextSpan(
                                text: 'Completed: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singleCompleted.projectEndDate,
                                style: kPageHeader,
                              )
                            ])),
                      ],
                    )
                  ],
                ),
              ),

              //Project Location and Venue
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 15),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kButtonColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 22,
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleCompleted.projectVenue,
                          style: kBodyTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleCompleted.projectLocation,
                          style: kBodyTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),

              //Project Description Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'About Project',
                  style: kBodyTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),

              //Project Description
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singleCompleted.projectDescription,
                  textAlign: TextAlign.justify,
                  style: kBodyTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
