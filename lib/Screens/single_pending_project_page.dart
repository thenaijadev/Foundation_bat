// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/pending_model.dart';
import '../constants/color_constant.dart';
import '../constants/text_style_constant.dart';
import '../providers/pending_provider.dart';

class PendingDetails extends StatefulWidget {
  final PendingModel singlePending;
  const PendingDetails( this.singlePending, {super.key});

  @override
  State<PendingDetails> createState() => _PendingDetailsState();
}

class _PendingDetailsState extends State<PendingDetails> {

@override
void initState() {
  super.initState();
  // Implement some initialization operations here.
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: kBackground,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: kBackground),
      ),
      body: RefreshIndicator(
        color: kBackground,
        backgroundColor: kButtonColor,
        onRefresh: () async {
          await Provider.of<PendingProvider>(context, listen: false)
              .getPendingProjects();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              //Project Image
              SizedBox(
                height: 265,
                child: CachedNetworkImage(
                  imageUrl: 'https://www.batnf.net/${widget.singlePending.projectImage}',
                  fit: BoxFit.cover,
                ),
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
                        RichText(
                            text: TextSpan(
                                text: 'To Begin: ',
                                style: kLandpageskiptextstyle,
                                children: [
                              TextSpan(
                                text: widget.singlePending.projectStartDate,
                                style: kPageHeader,
                              )
                            ])),
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
                  style: kBodyTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
        
              //Project Description
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singlePending.projectDescription,
                  textAlign: TextAlign.justify,
                  style: kBodyTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
     
      ));
  }
}