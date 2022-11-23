// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api
import 'package:batnf/Models/inprogress_model.dart';
import 'package:batnf/Screens/video_thumbnail.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class ProgressDetails extends StatefulWidget {
  final InprogressModel singleProgress;
  ProgressDetails(this.singleProgress, {Key? key}) : super(key: key);

  @override
  _ProgressDetailsState createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).hintColor,
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Project Image
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            padEnds: false,
                            autoPlayInterval: Duration(seconds: 10),
                            height: 265,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            // autoPlay: true
                          ),
                          items: widget.singleProgress.files!
                              .map((inprogressFile) {
                            if (inprogressFile.fileExt == '') {
                              return CachedNetworkImage(
                                  imageUrl:
                                      'https://www.batnf.net/${inprogressFile.thumbnail}',
                                  fit: BoxFit.cover);
                            } else if (inprogressFile.fileExt == 'image' &&
                                inprogressFile.thumbnail.isNotEmpty) {
                              return CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Center(child: Text('No Image Available')),
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  imageUrl:
                                      'https://www.batnf.net/${inprogressFile.fileUrl}',
                                  fit: BoxFit.cover);
                            }
                            return Videos(
                              thumbnailUrl: inprogressFile.thumbnail,
                              videoUrl: inprogressFile.fileUrl,
                            );
                          }).toList()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('previous'),
                        MaterialButton(
                          onPressed: () => _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear),
                          child: Icon(FontAwesomeIcons.arrowLeft),
                        ),
                        MaterialButton(
                          onPressed: () => _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear),
                          child: Icon(FontAwesomeIcons.arrowRight),
                        ),
                        Text('Next')
                      ],
                    )
                  ],
                ),
              ),

              //Project Title
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 30),
                child: Text(
                  widget.singleProgress.projectTitle,
                  style: kSingletitle,
                ),
              ),

              //Project Timeline
              Container(
                margin: EdgeInsets.only(left: 30, bottom: 21, right: 30),
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
                        color: kIcon,
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text.rich(
                              selectionColor: Theme.of(context).primaryColor,
                              TextSpan(
                                  text: 'Started: ',
                                  style: kSinglestart,
                                  children: [
                                    TextSpan(
                                      text: widget
                                          .singleProgress.projectStartDate,
                                      style: kStartdetail,
                                    )
                                  ])),
                                  SizedBox(height: 10),
                          Text.rich(
                              selectionColor: Theme.of(context).primaryColor,
                              TextSpan(
                                  text: 'To be Completed: ',
                                  style: kSinglestart,
                                  children: [
                                    TextSpan(
                                      text:
                                          widget.singleProgress.projectEndDate,
                                      style: kStartdetail,
                                    )
                                  ])),
                        ],
                      ),
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
                        color: kIcon,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleProgress.projectVenue,
                          style: kVenue,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleProgress.projectLocation,
                          style: kState,
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
                  style: kAboutTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),

              //Project Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: ReadMoreText(
                  widget.singleProgress.projectDescription,
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
