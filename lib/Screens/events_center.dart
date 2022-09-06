// ignore_for_file: prefer_const_constructors

// import 'package:batnf/Models/events_model.dart';

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/Screens/signin.dart';
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
  EventCenter({Key? key}) : super(key: key);

  @override
  _EventCenterState createState() => _EventCenterState();
}

class _EventCenterState extends State<EventCenter> {
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
        body: Column(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Container(
                        margin: EdgeInsets.only(
                          top: 47,
                          bottom: 22,
                        ),
                        decoration: BoxDecoration(
                            color: kSignupbuttonColor.withOpacity(0.15),
                            shape: BoxShape.circle),
                        height: 36,
                        child: IconButton(
                          icon: Icon(
                              size: 15,
                              FontAwesomeIcons.signOutAlt,
                              color: kButtonColor),
                          onPressed: () {
                            Navigator.pushNamed(context, SignIn.id);
                          },
                        ),
                      )
                    ],
                  ),
                  if (provider.allEvents != null &&
                      provider.allEvents!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 21),
                      color: kBackground,
                      height: 45.0,
                      child: TextField(
                        decoration: InputDecoration(
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
                          child: Text('No Events, \nPlease check Your Internet Connection \nand drag to Refresh', style: kBodyTextStyle,),
                        )
                      : RefreshIndicator(
                          color: kBackground,
                          backgroundColor: kButtonColor,
                        onRefresh:() async{
                          await Provider.of<EventProvider>(context,
                                    listen: false)
                                .getAllEvents();
                        } ,
                        child: ListView.builder(
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
                                  height: 124,
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
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18),
                                          child: CachedNetworkImage(
                                              imageUrl: 'https://portswigger.net/cms/images/63/12/0c8b-article-211117-linux-rng.jpg',
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 93,
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 10,
                                              left: 10.0,
                                              right: 6.0),
                                          color: kBackground,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Container(
                                                color: kBackground,
                                                height: 19,
                                                child: Text(
                                                  event.eventDate,
                                                  style: kEventDatestyle,
                                                ),
                                              ),
                                              Container(
                                                color: kBackground,
                                                height: 38,
                                                child: Text(
                                                  event.eventName,
                                                  style: kPageHeader,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  color: kBackground,
                                                  height: 86,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 6.67,
                                                            bottom: 23.67),
                                                        color: kBackground,
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .mapMarkerAlt,
                                                          size: 14.67,
                                                          color:
                                                              kTextboxhintColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                            top: 5,
                                                            right: 11,
                                                          ),
                                                          height: 32,
                                                          width: 207,
                                                          color: kBackground,
                                                          child: Text(
                                                            textAlign:
                                                                TextAlign.left,
                                                            event.venue,
                                                            style: TextStyle(
                                                                color:
                                                                    kTextboxhintColor,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
            ),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
