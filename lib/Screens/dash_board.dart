// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/Screens/single_event_page.dart';
import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/providers/event_provider.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';

import '../Models/completed_model.dart';
import '../Models/events_model.dart';
import '../providers/completed_provider.dart';
import '../providers/news_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // @override
  // void initState() {
  //   super.initState();
  //   FlutterNativeSplash.remove();
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    Provider.of<EventProvider>(context, listen: false).getAllEvents();
    Provider.of<CompletedProvider>(context, listen: false)
        .getCompletedProjects();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    CompletedProvider completedProvider =
        Provider.of<CompletedProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // Container for search box etc
            Container(
              height: 173.0,
              color: kBackground,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 24.0, top: 45, bottom: 20, right: 190),
                        color: kBackground,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
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
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
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
              child: ListView(
                children: [
                  
                  //Ads
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    color: kBackground,
                    child: Image.asset('assets/Ads.png'),
                  ),

                  // Project List Header
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Projects',
                          style: kPageHeader,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ProjectPage.id);
                          },
                          child: Text(
                            'See All',
                            style: kForgetpasswordstyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 205,
                    width: 237,
                    child: completedProvider.allCompletedProjects == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : completedProvider.allCompletedProjects!.isEmpty
                            ? Center(
                                child: Text(
                                  'Please check Your Internet Connection',
                                  style: kBodyTextStyle,
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: ((context, index) {
                                  CompletedModel completed = completedProvider
                                      .allCompletedProjects![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompletedProjectDetails(
                                                      completed)));
                                    },
                                    child: Container(
                                      height: 202,
                                      width: 237,
                                      margin: EdgeInsets.only(
                                          left: 36.27,
                                          right: 15.0,
                                          bottom: 9.0),
                                      decoration: BoxDecoration(
                                        boxShadow: [kBoxshadow],
                                        color: kBackground,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 145,
                                            width: 217,
                                            margin: EdgeInsets.only(
                                                left: 9.0, right: 10.15),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      completed.projectImage,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 16, left: 39, bottom: 16),
                                            height: 19,
                                            child: Text(
                                              completed.projectTitle,
                                              style: kPageHeader,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                  ),

                  //Upcoming events header
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Events',
                          style: kPageHeader,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, EventCenter.id);
                          },
                          child: Text(
                            'See All',
                            style: kForgetpasswordstyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 320,
                    width: 237,
                    child: eventProvider.allEvents == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : eventProvider.allEvents!.isEmpty
                            ? Center(
                                child: Text(
                                  'Please check Your Internet Connection',
                                  style: kBodyTextStyle,
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  EventModel event =
                                      eventProvider.allEvents![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventDetails(event)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 36.27,
                                          right: 15.0,
                                          bottom: 9.0),
                                      decoration: BoxDecoration(
                                        boxShadow: [kBoxshadow],
                                        color: kBackground,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      height: 255.0,
                                      width: 237.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 6.0),
                                            margin: EdgeInsets.only(
                                                left: 9.0, right: 10.15),
                                            height: 145,
                                            width: 218,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: CachedNetworkImage(
                                                  imageUrl: event.eventFlier,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0,
                                                left: 9.0,
                                                bottom: 10.0),
                                            child: Text(
                                              event.eventName,
                                              style: kPageHeader,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 9.0, bottom: 10.0),
                                            child: Text(
                                              event.eventStartDate,
                                              style: kWelcomesubstyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, bottom: 27.0),
                                            child: ListTile(
                                              leading: Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                color: kTextboxhintColor,
                                              ),
                                              title: Text(
                                                event.venue,
                                                textAlign: TextAlign.left,
                                                style: kWelcomesubstyle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                  ),

                  // News list header

                  Container(
                    color: kBackground,
                    height: 419,
                    width: 375,
                    child: Column(
                      children: [
                        // News label
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'News',
                                style: kPageHeader,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => News()));
                                },
                                child: Text(
                                  'See All',
                                  style: kForgetpasswordstyle,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: newsProvider.allNews == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : newsProvider.allNews!.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No Latest News, \nPlease check Your Internet Connection \nand drag to Refresh',
                                        style: kBodyTextStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: 3,
                                      itemBuilder: ((context, index) {
                                        NewsModel news =
                                            newsProvider.allNews![index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 23.0, right: 23.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewsDetails(news)));
                                            },
                                            child: Container(
                                              color: kBackground,
                                              height: 120,
                                              width: 375,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 15.0,
                                                        right: 15.0),
                                                    height: 120,
                                                    width: 120,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      child: CachedNetworkImage(
                                                          imageUrl:
                                                              news.newsImage,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 120,
                                                      margin: EdgeInsets.only(
                                                          bottom: 15.0),
                                                      color: kBackground,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          Text(
                                                            news.title,
                                                            style:
                                                                kNewsSubHeader,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                color:
                                                                    kBackground,
                                                                height: 7.0,
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  news.information,
                                                                  style:
                                                                      kBodyTextStyle,
                                                                )),
                                                          ),
                                                          Text(
                                                            textAlign:
                                                                TextAlign.left,
                                                            news.entryDate,
                                                            style:
                                                                kNewsDateSTyle,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 50.0,
                  ),

                  // Visit Market Link
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 150.0),
                    child: Center(
                      child: Container(
                        height: 107,
                        width: 368,
                        // ignore: sort_child_properties_last
                        child: Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            height: 45,
                            minWidth: 230,
                            color: kButtonColor,
                            onPressed: () {},
                            child: Text(
                              "Visit Our Famer's Market",
                              style: TextStyle(
                                  color: kBackground,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/market.png'))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
