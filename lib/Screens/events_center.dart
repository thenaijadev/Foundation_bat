// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

// import 'package:batnf/Models/events_model.dart';

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/Screens/single_event_page.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/providers/event_provider.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventCenter extends StatefulWidget {
  static String id = 'event';
  EventCenter({Key? key}) : super(key: key);

  @override
  _EventCenterState createState() => _EventCenterState();
}

class _EventCenterState extends State<EventCenter> {
  final String uri = 'https://www.batnf.net/';
  @override
  void initState() {
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    EventProvider provider = Provider.of<EventProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<EventProvider>(context, listen: false)
                .getAllEvents();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container for search box etc
              Container(
                color: kBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                          color: kBackground,
                          height: 40.0,
                          child: Image.asset(
                            'assets/logo.png',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 50, left: 10, bottom: 26, right: 130),
                          color: kBackground,
                          height: 29,
                          child: Text(
                            'Events',
                            style: kPageHeader,
                          ),
                        ),
                      ],
                    ),
                    if (provider.allEvents != null &&
                        provider.allEvents!.isNotEmpty)
                      Container(
                        margin:
                            EdgeInsets.only(left: 30, right: 30, bottom: 21),
                        color: kBackground,
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            hintText: 'Search',
                            hintStyle: kTextboxhintstyle,
                            prefixIcon: Icon(
                              FontAwesomeIcons.search,
                              size: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.0),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: kTextfieldborderColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Expanded(
                child: provider.allEvents == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.allEvents!.isEmpty
                        ? Center(
                            child: Image.asset('assets/noitem.png.gif'),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: provider.allEvents!.length,
                            itemBuilder: ((context, index) {
                              EventModel event = provider.allEvents![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EventDetails(event)));
                                },
                                child: Container(
                                  // height: 124,
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kBackground,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        margin: EdgeInsets.only(
                                            bottom: 7.0, top: 7.0, left: 9.0),
                              
                                        // Event Image
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: provider
                                                  .allEvents![index]
                                                  .files![0]
                                                  .fileExt
                                                  .isEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://www.batnf.net/${event.eventFlier}',
                                                      fit: BoxFit.cover),
                                                )
                                              : CachedNetworkImage(
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              placeholder: (context, url) =>
                                                  CachedNetworkImage(
                                                      imageUrl:
                                                          'https://www.batnf.net/${event.eventFlier}'),
                                              imageUrl:
                                                  'https://www.batnf.net/${event.files![0].fileUrl}',
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 93,
                                          margin: EdgeInsets.only(
                                              // top: 5,
                                              left: 10.0,
                                              right: 6.0),
                                          color: kBackground,
                                          //Event Information
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text(
                                                event.eventStartDate,
                                                style: kEventDatestyle,
                                              ),
                                              Text(
                                                event.eventName,
                                                style: kPageHeader,
                                              ), //Event Location
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  //Event Location Icon
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .mapMarkerAlt,
                                                    size: 16.67,
                                                    color: kTextboxhintColor,
                                                  ),
                              
                                                  //Event Location
                                                  Text(
                                                    event.eventLocation,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color:
                                                            kTextboxhintColor,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontFamily: 'Inter',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
