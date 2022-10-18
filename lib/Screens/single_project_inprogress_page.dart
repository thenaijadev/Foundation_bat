// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/inprogress_provider.dart';

class ProgressDetails extends StatefulWidget {
  final InprogressModel singleProgress;
  ProgressDetails(this.singleProgress, {Key? key}) : super(key: key);

  @override
  _ProgressDetailsState createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  @override
  Widget build(BuildContext context) {
    InprogressProvider provider = Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leading: BackButton(color: kBackground,),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          
        ),
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<InprogressProvider>(context, listen: false)
                .getInprogressProjects();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Project Image
                SizedBox(
                    height: 265,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: provider.allInprogressProjects!.length,
                        itemBuilder: ((context, index) {
                          // InprogressModel inprogress =
                          //     provider.allInprogressProjects![index];
          
                          return CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              // placeholder: (context, url) => CachedNetworkImage(
                              //     imageUrl:
                              //         'https://www.batnf.net/${widget.singleProgress.projectImage}'),
                              imageUrl:
                                  'https://www.batnf.net/${widget.singleProgress.files![index].fileUrl}',
                              fit: BoxFit.cover);
                        }))
                    // ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       CachedNetworkImage(
                    //           errorWidget: (context, url, error) =>
                    //               Icon(Icons.error),
                    //           placeholder: (context, url) => CachedNetworkImage(
                    //               imageUrl:
                    //                   'https://www.batnf.net/${widget.singleProgress.projectImage}'),
                    //           imageUrl:
                    //               'https://www.batnf.net/${widget.singleProgress.files![index].fileUrl}',
                    //           fit: BoxFit.cover)
                    //     ],
                    //   ),
                    // CachedNetworkImage(
                    //   imageUrl: 'https://www.batnf.net/${widget.singleProgress.files![0].fileUrl}',
                    //   fit: BoxFit.cover,
                    // ),
                    ),
          
                //Project Title
                Container(
                  margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                  child: Text(
                    widget.singleProgress.projectTitle,
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
                                  text: widget.singleProgress.projectStartDate,
                                  style: kPageHeader,
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: 'To be Completed: ',
                                  style: kLandpageskiptextstyle,
                                  children: [
                                TextSpan(
                                  text: widget.singleProgress.projectEndDate,
                                  style: kPageHeader,
                                )
                              ])),
                        ],
                      )
                    ],
                  ),
                ),
          
                //Project Location and venue
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
                            widget.singleProgress.projectVenue,
                            style: kPageHeader,
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.singleProgress.projectLocation,
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
                  margin:
                      EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                  child: Text(
                    widget.singleProgress.projectDescription,
                    textAlign: TextAlign.justify,
                    style: kBodyTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
