// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/video_thumbnail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

import '../Models/pending_model.dart';
import '../constants/color_constant.dart';
import '../constants/text_style_constant.dart';

class PendingDetails extends StatefulWidget {
  final PendingModel singlePending;
  const PendingDetails( this.singlePending, {super.key});

  @override
  State<PendingDetails> createState() => _PendingDetailsState();
}

class _PendingDetailsState extends State<PendingDetails> {
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: kBackground),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            //Project Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 10),
                  height: 350,
                  viewportFraction: 1.0,
                      padEnds: false,
                  // autoPlay: true
                ),
                items: widget.singlePending.files!.map((pendingFile) {
                if (pendingFile.fileExt == ' ') {
                    return CachedNetworkImage(
                        placeholder: (context, url) => Center(
                                child: Text(
                              'Loading',
                              style: TextStyle(color: Colors.black),
                            )),
                        imageUrl:
                            'https://www.batnf.net/${pendingFile.thumbnail}',
                        fit: BoxFit.cover);
                  } else if (pendingFile.fileExt == 'image/jpeg') {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                  child: Text('Loading...', style: TextStyle(color: Colors.black),
                                  ),
                                ),
                            imageUrl:
                                'https://www.batnf.net/${pendingFile.fileUrl}',
                            fit: BoxFit.cover);
                      } return Videos(
                        thumbnailUrl: pendingFile.thumbnail,
                        videoUrl: pendingFile.fileUrl,
                      );
                }).toList())
            ),
      
            //Project Title
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
              child: Text(
                widget.singlePending.projectTitle,
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
                      Text(
                              'To Begin: ',
                              style: kLandpageskiptextstyle,
                          ),
                            Text(
                               widget.singlePending.projectStartDate,
                              style: kPageHeader,
                            )
                    ],
                  )
                ],
              ),
            ),
      
             //Project venue and location
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
                        widget.singlePending.projectVenue,
                        style: kBodyTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.singlePending.projectLocation,
                        style: kBodyTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
      
            //Project description Header
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'About Project',
                style: kAboutTextStyle,
                textAlign: TextAlign.left,
              ),
            ),
      
            //Project Description
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
              child: ReadMoreText(
                widget.singlePending.projectDescription,
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
     
      ));
  }
}