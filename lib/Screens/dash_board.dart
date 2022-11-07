// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/single_event_page.dart';
import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/providers/event_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Models/events_model.dart';
import '../Models/files.dart';
import '../Models/inprogress_model.dart';
import '../providers/inprogress_provider.dart';
import '../providers/news_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../widgets/change_theme_button.dart';

class HomePage extends StatefulWidget {
  static String id = 'home';
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    Provider.of<EventProvider>(context, listen: false).getAllEvents();
    Provider.of<InprogressProvider>(context, listen: false).getInprogressProjects();
    getId();
    FlutterNativeSplash.remove();
     }


  getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    EventProvider provider = Provider.of<EventProvider>(context, listen: false);
    bool exist = sharedPreferences.containsKey('autoLogin') &&
        sharedPreferences.containsKey('userId') &&
        sharedPreferences.containsKey('username');
    if (exist) {
      bool autoLogin = sharedPreferences.getBool('autoLogin')!;

      if (autoLogin) {
        int userID = sharedPreferences.getInt('userId')!;
        String username = sharedPreferences.getString('username')!;
        provider.userId = userID;
        provider.userName = username;
        // user = username;
      }
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';
    NewsProvider newsProvider =
        Provider.of<NewsProvider>(context, listen: false);
    EventProvider eventProvider =
        Provider.of<EventProvider>(context, listen: false);
    InprogressProvider inprogressProvider =
        Provider.of<InprogressProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 60,
            backgroundColor: Theme.of(context).primaryColor,
            title: Center(
                child: Text('Home',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue,
                    ))),
            // App Logo
            actions: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 20, right: 45),
                height: 40.0,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ],
            // Drawer Builder
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    FontAwesomeIcons.bars,
                    color: Colors.blue,
                  ));
            })),
            // Drawer
        drawer: Drawer(
          width: 250,
          backgroundColor: Theme.of(context).primaryColor,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // UserAccountsDrawerHeader(
              //   accountName: Text('paul'),
              //   accountEmail: Text('$email'),
              //   decoration: BoxDecoration(color: Colors.lightBlue),
              // ),
              SizedBox(
                height: 50,
              ),

              //Header
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 26,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      FontAwesomeIcons.cogs,
                      color: Colors.red,
                      size: 24,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // Change  Theme Option
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  'Change App Theme',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
              InkWell(
                child: ListTile(
                    title: Text(
                      text,
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                    leading: ChangeThemeButtonWidget()),
              ),

              // User Profile
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //       title: Text(
              //         'User Profile',
              //         style:
              //             TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              //       ),
              //       leading: Icon(FontAwesomeIcons.userAlt,
              //           color: Colors.lightBlue)),
              // ),

              //Change User Password
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ResetPassword.id);
                },
                child: ListTile(
                    title: Text(
                      'Change Password',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(FontAwesomeIcons.userLock,
                        color: Colors.lightBlue)),
              ),

              //Logout option
              InkWell(
                onTap: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool('autoLogin', false);

                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomePage.id, (Route<dynamic> route) => false);
                },
                child: ListTile(
                    title: Text(
                      'LogOut',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(FontAwesomeIcons.signOutAlt,
                        color: Colors.lightBlue)),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // Image Sliders
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        scrollDirection: Axis.horizontal,
                        padEnds: true,
                        autoPlayCurve: Curves.easeInQuint,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        viewportFraction: 1,
                        autoPlay: true),
                    items: [
                      Container(
                        // ignore: sort_child_properties_last
                        child: Center(
                            child: Text(
                                'Providing Support in the Agricultural Sector',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kGeneralbodytextColor,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/market.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // ignore: sort_child_properties_last
                        child: Center(
                            child: Text('Get Latest News on Batnf',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kGeneralbodytextColor,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/onboarding3.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // ignore: sort_child_properties_last
                        child: Center(
                            child: Text(
                                'Follow-up on Projects Carried out by Batnf',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kGeneralbodytextColor,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/onboarding4.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // ignore: sort_child_properties_last
                        child: Center(
                            child: Text(
                                'Register and Attend Events Hosted by Batnf',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kGeneralbodytextColor,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/boarding1.png',
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/Ads3.png',
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
              ),

              // Project List Header
             SizedBox(
                height: 150,
                width: 365,
                child: Column(
                  children: [
                    // Projects label
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Projects',
                            style: kPageHeader,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProjectPage()));
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
                      child: inprogressProvider.allInprogressProjects == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : inprogressProvider.allInprogressProjects!.isEmpty
                              ? Center(
                                  child: Image.asset('assets/noitem.png.gif'),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: inprogressProvider
                                      .allInprogressProjects!.length,
                                  itemBuilder: ((context, index) {
                                    InprogressModel inprogress =
                                        inprogressProvider
                                            .allInprogressProjects![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProgressDetails(
                                                          inprogress)));
                                        },
                                        child: Container(
                                            color:Colors.transparent,
                                          width: 375,
                                          child: Row(
                                            children: [
                                              //Images and Videos for Inprogress Projects
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10.0,
                                                    right: 15.0),
                                                height: 100,
                                                width: 180,
                                                child: inprogress.files!.first
                                                                .fileExt ==
                                                            'image/jpeg' &&
                                                        inprogress.files!.first
                                                            .fileUrl.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: CachedNetworkImage(
                                                           errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.error,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                    placeholder:
                                                                        (context, url) =>
                                                                            Center(
                                                                              child: Text(
                                                                                'Loading',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${inprogress.files!.first.fileUrl}',
                                                            fit: BoxFit.cover),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: CachedNetworkImage(
                                                           errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.error,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            'Loading',
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${inprogress.files!.first.thumbnail}',
                                                            fit: BoxFit.cover),
                                                      ),
                                              ),

                                              //Details
                                              Container(
                                                height: 100,
                                                width: 180,
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10.0),
                                                decoration: BoxDecoration(
                                                  boxShadow: [kBoxshadow],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Text(
                                                      inprogress.projectTitle,
                                                      style: kNewsSubHeader,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      inprogress
                                                          .projectDescription,
                                                      textAlign: TextAlign.left,
                                                      style: kBodyTextStyle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    Text(
                                                      inprogress
                                                          .projectStartDate,
                                                      textAlign: TextAlign.left,
                                                      style: kNewsDateSTyle,
                                                    )
                                                  ],
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

              // Events
              SizedBox(
                height: 150,
                width: 365,
                child: Column(
                  children: [
                    // Event label
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Events',
                            style: kPageHeader,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventCenter()));
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
                      child: eventProvider.allEvents == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : eventProvider.allEvents!.isEmpty
                              ? Center(
                                  child: Image.asset('assets/noitem.png.gif'),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: eventProvider.allEvents!.length,
                                  itemBuilder: ((context, index) {
                                    EventModel events =
                                        eventProvider.allEvents![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetails(events)));
                                        },
                                        child: Container(
                                            color:Colors.transparent,
                                          // height: 120,
                                          width: 375,
                                          child: Row(
                                            children: [
                                              //Images
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10.0,
                                                    right: 15.0),
                                                height: 100,
                                                width: 180,
                                                child:
                                                    events.files!.first
                                                                .fileExt ==
                                                            'image/jpeg' &&
                                                        events.files!.first
                                                            .fileUrl.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: CachedNetworkImage(
                                                           errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.error,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                    placeholder:
                                                                        (context, url) =>
                                                                            Center(
                                                                              child: Text(
                                                                                'Loading',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${events.files!.first.fileUrl}',
                                                            fit: BoxFit.cover),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: CachedNetworkImage(
                                                           errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.error,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            'Loading',
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${events.files!.first.thumbnail}',
                                                            fit: BoxFit.cover),
                                                      ),
                                              ),
                                              //Details
                                              Container(
                                                height: 100,
                                                width: 180,
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10.0),
                                                decoration: BoxDecoration(
                                                  boxShadow: [kBoxshadow],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Text(
                                                      events.eventName,
                                                      style: kNewsSubHeader,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      events.eventDesc,
                                                      textAlign: TextAlign.left,
                                                      style: kBodyTextStyle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    Text(
                                                      events.eventStartDate,
                                                      textAlign: TextAlign.left,
                                                      style: kNewsDateSTyle,
                                                    )
                                                  ],
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

              // News list header
              SizedBox(
                height: 150,
                width: 365,
                child: Column(
                  children: [
                    // News label
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
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
                                  child: Image.asset('assets/noitem.png.gif'),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: newsProvider.allNews!.length,
                                  itemBuilder: ((context, index) {
                                    NewsModel news =
                                        newsProvider.allNews![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetails(news)));
                                        },
                                        child: Container(
                                            color:Colors.transparent,
                                          width: 375,
                                          child: Row(
                                            children: [
                                              //Images
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10.0,
                                                      right: 15.0),
                                                  height: 100,
                                                  width: 180,
                                                  child: news.files!.first.fileExt ==
                                                    'image/jpeg' &&
                                                news.files!.first.fileUrl
                                                    .isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: CachedNetworkImage(
                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.error,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                    placeholder:
                                                                        (context, url) =>
                                                                            Center(
                                                                              child: Text(
                                                                                'Loading',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),

                                                    imageUrl:
                                                        'https://www.batnf.net/${news.files!.first.fileUrl}',
                                                    fit: BoxFit.cover),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.black,),),
                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                              child: Text(
                                                                                'Loading',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),

                                                    imageUrl:
                                                        'https://www.batnf.net/${news.files!.first.thumbnail}',
                                                    fit: BoxFit.cover),
                                              ),
                                                  ),

                                              //Details
                                              Container(
                                                // height: 100,
                                                width: 180,
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10.0),
                                                decoration: BoxDecoration(
                                                  boxShadow: [kBoxshadow],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Text(
                                                      news.title,
                                                      style: kNewsSubHeader,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      // textAlign:
                                                      //     TextAlign.justify,
                                                    ),
                                                    Text(
                                                      news.entryDate,
                                                      textAlign: TextAlign.left,
                                                      style: kNewsDateSTyle,
                                                    )
                                                  ],
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
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
