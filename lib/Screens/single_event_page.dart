// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:batnf/services/registration.dart';

import '../providers/event_provider.dart';

class EventDetails extends StatefulWidget {
  final EventModel singleEvent;

  EventDetails(this.singleEvent, {Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<EventProvider>(context, listen: false)
                .getAllEvents();
          },
          child: ListView(
            children: [
              //Event Image
              SizedBox(
                height: 150,
                width: 428,
                child: CachedNetworkImage(
                  imageUrl: widget.singleEvent.eventFlier,
                  fit: BoxFit.fitWidth,
                ),
              ),

              //Event Name
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                child: Text(
                  widget.singleEvent.eventName,
                  style: kPageHeader,
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
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.eventStartDate,
                          style: kBodyTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleEvent.eventStartTime,
                          style: kBodyTextStyle,
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
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.venue,
                          style: kBodyTextStyle,
                        ),
                        Text(
                          widget.singleEvent.eventLocation,
                          style: kBodyTextStyle,
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
                ),
              ),

              //Event Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  textAlign: TextAlign.justify,
                  widget.singleEvent.eventDesc,
                  style: kBodyTextStyle,
                ),
              ),

              //Map Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Location'),
              ),

              // Location Map
              Container(
                height: 192,
                margin:
                    EdgeInsets.only(left: 30, top: 10, bottom: 75, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset('assets/map.png'),
              ),

              //Registration Button
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 20.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  height: 45.0,
                  color: kButtonColor,
                  onPressed: () {},
                  child: Text(
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
