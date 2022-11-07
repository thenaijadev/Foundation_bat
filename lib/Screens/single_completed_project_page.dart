// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/completed_model.dart';
import 'package:batnf/Screens/video_thumbnail.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

import '../constants/color_constant.dart';



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
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              // Project Image
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: CarouselSlider(
                    options: CarouselOptions(
                      padEnds: false,
                      autoPlayInterval: Duration(seconds: 10),
                      height: 350,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      // autoPlay: true
                    ),
                    items: widget.singleCompleted.files!.map((completedFile) {
                      if (completedFile.fileExt == ' ') {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                    child: Text(
                                  'Loading',
                                  style: TextStyle(color: Colors.black),
                                )),
                            imageUrl:
                                'https://www.batnf.net/${completedFile.thumbnail}',
                            fit: BoxFit.cover);
                      } else if (completedFile.fileExt == 'image/jpeg') {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                  child: Text(
                                    'Loading...',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                            imageUrl:
                                'https://www.batnf.net/${completedFile.fileUrl}',
                            fit: BoxFit.cover);
                      }
                      return Videos(
                        thumbnailUrl: completedFile.thumbnail,
                        videoUrl: completedFile.fileUrl,
                      );
                    }).toList()),
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
                        Text.rich(
                             TextSpan(
                                text: 'Started: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singleCompleted.projectStartDate,
                                style: kPageHeader,
                              )
                            ])),
                            Text.rich(
                            TextSpan(
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
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: ReadMoreText(
                  widget.singleCompleted.projectDescription,
                  textAlign: TextAlign.justify,
                  style: kBodyTextStyle,
                  trimLength: 150,
                  trimMode: TrimMode.Line,
                  trimLines: 15,
                  trimCollapsedText: 'Read More',
                  trimExpandedText: 'Show Less',
                  lessStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                  moreStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
