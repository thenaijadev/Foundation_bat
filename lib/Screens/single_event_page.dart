// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/Screens/video_thumbnail.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

import '../providers/event_provider.dart';

class EventDetails extends StatefulWidget {
  final EventModel singleEvent;

  EventDetails(this.singleEvent, {Key? key}) : super(key: key);

  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool loading = false;
  Future<void> register({required int userId, required String eventId}) async {
    var response =
        await http.post(Uri.parse('https://www.batnf.net/api/attendevent'),
            body: jsonEncode({
              "userId":
                  Provider.of<EventProvider>(context, listen: false).userId,
              "eventId": widget.singleEvent.eventId,
            }),
            headers: {"Content-Type": "application/json"});

    var data = jsonDecode(response.body);
    print(data);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        print(Provider.of<EventProvider>(context, listen: false).userId);
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: data['message'],
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    } else {
      Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          msg: 'Service Timeout',
          textColor: kBackground,
          backgroundColor: kButtonColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Event Image
              PageIndicatorContainer(
                align: IndicatorAlign.center,
                indicatorColor: Color(0xffBDBDBD),
                indicatorSelectorColor: Colors.black,
                indicatorSpace: 10.0,
                shape: IndicatorShape.circle(size: 108),
                length: 4,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ClipRRect(
                    child: CarouselSlider(
                        options: CarouselOptions(
                          padEnds: false,
                          autoPlayInterval: Duration(seconds: 10),
                          height: 265,
                          viewportFraction: 0.95,
                          enableInfiniteScroll: false,
                          // autoPlay: true
                        ),
                        items: widget.singleEvent.files!.map((eventsFile) {
                          if (eventsFile.fileExt == '') {
                            return CachedNetworkImage(
                                imageUrl:
                                    'https://www.batnf.net/${eventsFile.thumbnail}',
                                fit: BoxFit.cover);
                          } else if (eventsFile.fileExt == 'image'  &&
                              eventsFile.thumbnail.isNotEmpty) {
                            return CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    Center(child: Text('No Image/Video Available')),
                                placeholder: (context, url) => Center(
                                        child: Text(
                                      'Loading',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                imageUrl:
                                    'https://www.batnf.net/${eventsFile.fileUrl}',
                                fit: BoxFit.cover);
                          } return Videos(thumbnailUrl: eventsFile.thumbnail, videoUrl: eventsFile.fileUrl,);
                        }).toList()),
                  ),
                ),
              ),

              //Event Name
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 30),
                child: Text(
                  widget.singleEvent.eventName,
                  style: kSingletitle,
                ),
              ),

              //Event Timeline and Dates
              Container(
                margin: EdgeInsets.only(left: 30, bottom: 21),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(8),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.eventStartDate,
                          style: kStartdetail,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleEvent.eventStartTime,
                          style: kStartdetail,
                        )
                      ],
                    )
                  ],
                ),
              ),

              //Event Location
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
                        size: 25,
                        color: kIcon,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.venue,
                          style: kVenue,
                        ),
                        Text(
                          widget.singleEvent.eventLocation,
                          style: kState,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //Description Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'About Event',
                  textAlign: TextAlign.left,
                  style: kAboutTextStyle,
                ),
              ),

              //Event Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: ReadMoreText(
                  widget.singleEvent.eventDesc,
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

              //Map Header
              // Padding(
              //   padding: const EdgeInsets.only(left: 30),
              //   child: Text('Location'),
              // ),

              // // Location Map
              // Container(
              //   height: 192,
              //   margin:
              //       EdgeInsets.only(left: 30, top: 10, bottom: 75, right: 30),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Image.asset('assets/map.png'),
              // ),

              //Registration Button
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 20.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  height: 45.0,
                  minWidth: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 8, 51, 121),
                  onPressed: () {
                        // .userId);
                      setState(() {
                        loading = true;
                      });
                      register(
                          userId:
                              Provider.of<EventProvider>(context, listen: false)
                                  .userId,
                          eventId: widget.singleEvent.eventId);
                    
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white))
                      : Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: kButtontextstyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
