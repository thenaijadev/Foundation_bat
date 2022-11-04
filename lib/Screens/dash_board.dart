// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/inprogress_project.dart';
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
  InprogressModel? inprogress ;
  List<CachedVideoPlayerController> playerController = [];
    CachedVideoPlayerController? controller ;

  @override
  void initState() {
    super.initState();
    // video(inprogress!.files![0].fileUrl as List<Files>);
    getId();
    FlutterNativeSplash.remove();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    Provider.of<EventProvider>(context, listen: false).getAllEvents();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    controller = CachedVideoPlayerController.network(
        // 'https://www.batnf.net/${ inprogress!.files![index].fileUrl
        // //   //  inprogress.files![0].fileUrl
        //  }'
        // 'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        );
    controller!.initialize().then((value) {
      // controller.play();
      setState(() {});
    });
  }

  void video(List<Files> file) async {
    if (file.isEmpty) return;
    List<Files> videoList =
        file.where((element) => element.fileExt == 'video/mp4').toList();
    int count =
        videoList.fold(0, (previousValue, element) => previousValue + 1);
    var inprogress;
    playerController = List.generate(
        count,
        (index) => CachedVideoPlayerController.network(
            // 'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4',
            'https://www.batnf.net/${inprogress.files![index].fileUrl}'
            ));

    for (var element in playerController) {
      element.initialize().then((value) async {
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
    for (var element in playerController) {
      element.dispose();
    }
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
            // Colors.lightBlueAccent.withOpacity(0.98),
            title: Center(
                child: Text('Home',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue,
                    ))),
            actions: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 20, right: 45),
                // color: Theme.of(context).primaryColor,
                height: 40.0,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ],
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
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text(
                      'User Profile',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(FontAwesomeIcons.userAlt,
                        color: Colors.lightBlue)),
              ),

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // // Container for search box etc
            // Container(
            //   // height: 200.0,
            //   color: Theme.of(context).primaryColor.withOpacity(0.95),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //             margin:
            //                 EdgeInsets.only(top: 45, bottom: 20, right: 135),
            //             color: Theme.of(context).primaryColor,
            //             height: 40.0,
            //             child: Image.asset(
            //               'assets/logo.png',
            //             ),
            //           ),

            //           Container(
            //               color: Theme.of(context).primaryColor,
            //               margin: EdgeInsets.only(top: 10),
            //               child: Column(
            //                 children: [
            //                   Text(
            //                     text,
            //                     style: TextStyle(
            //                         fontSize: 12, fontStyle: FontStyle.italic),
            //                   ),
            //                   ChangeThemeButtonWidget(),
            //                 ],
            //               )),
            //           Container(
            //             margin: EdgeInsets.only(
            //               top: 47,
            //               bottom: 22,
            //             ),
            //             decoration: BoxDecoration(
            //                 color: kSignupbuttonColor.withOpacity(0.15),
            //                 shape: BoxShape.circle),
            //             height: 36,
            //             child: IconButton(
            //               icon: Icon(FontAwesomeIcons.signOutAlt,
            //                   size: 15, color: Colors.blue),
            //               onPressed: () async {
            //                 final SharedPreferences sharedPreferences =
            //                     await SharedPreferences.getInstance();
            //                 sharedPreferences.setBool('autoLogin', false);

            //                 Navigator.pushNamedAndRemoveUntil(
            //                     context,
            //                     WelcomePage.id,
            //                     (Route<dynamic> route) => false);
            //               },
            //             ),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CarouselSlider(
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
                                  'assets/boarding3.png',
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/Ads.png',
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
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
                                  'assets/boarding4.png',
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
                        options: CarouselOptions(
                            height: 150,
                            scrollDirection: Axis.horizontal,
                            padEnds: true,
                            autoPlayCurve: Curves.easeInQuint,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            viewportFraction: 0.99,
                            autoPlay: true)),
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
                            Navigator.pushNamed(context, InprogressPage.id);
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
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProgressDetails(inprogress)));
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
                                        color: Theme.of(context).primaryColor,
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
                                            child: 
                                            inprogress.files![index]
                                                    .fileUrl.isEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.files![index].thumbnail}',
                                                        fit: BoxFit.cover),
                                                  )
                                                : inprogress.files![index]
                                                            .fileExt ==
                                                        'video/mp4'
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: controller!.value
                                                                .isInitialized
                                                            ? AspectRatio(
                                                                aspectRatio:
                                                                    controller!
                                                                        .value
                                                                        .aspectRatio,
                                                                child: CachedVideoPlayer(
                                                                    controller!))
                                                            : CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${inprogress.files![index].thumbnail}',
                                                        fit: BoxFit.cover),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: CachedNetworkImage(
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Center(
                                                                    child: Text(
                                                                        'No Image Availaible')),
                                                            imageUrl: 'https://www.batnf.net/${inprogress.files![index].fileUrl}',
                                                            fit: BoxFit.cover),
                                                      ),
                                          ),

                                          //Title
                                          
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 16, left: 39, bottom: 16),
                                            height: 19,
                                            child: Text(
                                              inprogress.projectTitle,
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
                                child: Image.asset('assets/noitem.png.gif'),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: eventProvider.allEvents!.length,
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
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      height: 255.0,
                                      width: 237.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // padding:
                                            //     EdgeInsets.only(bottom: 6.0),
                                            margin: EdgeInsets.only(
                                                left: 9.0, right: 10.15),
                                            height: 145,
                                            width: 218,
                                            child: event.files![index].fileExt
                                                    .isEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.batnf.net/${event.files![index].thumbnail}', 
                                                        // fit: BoxFit.contain
                                                        ),
                                                  )
                                                : ClipRRect(
                                                  borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  child: CachedNetworkImage(
                                                      errorWidget:
                                                          (context, url, error) =>
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                    'https://www.batnf.net/${event.files![index].thumbnail}',
                                                                // fit: BoxFit.fill,
                                                              ),
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                                child: Text(
                                                                    'Loading...'),
                                                              ),
                                                      imageUrl:
                                                          'https://www.batnf.net/${event.files![index].fileUrl}',
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
                                              style: kEventsub,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, bottom: 27.0),
                                            child: ListTile(
                                              leading: Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                color: Colors.blue,
                                              ),
                                              title: Text(
                                                event.venue,
                                                textAlign: TextAlign.left,
                                                style: kEventsub,
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

                  SizedBox(
                    // color: kBackground,
                    height: 419,
                    width: 375,
                    child: Column(
                      children: [
                        // News label
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, bottom: 50),
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
                                      child:
                                          Image.asset('assets/noitem.png.gif'),
                                    )
                                  : ListView.builder(
                                      itemCount: newsProvider.allNews!.length,
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
                                              margin: EdgeInsets.only(top: 25),
                                              decoration: BoxDecoration(
                                                boxShadow: [kBoxshadow],
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              // height: 120,
                                              width: 375,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 15.0,
                                                        right: 15.0),
                                                    height: 120,
                                                    width: 120,
                                                    child: news
                                                                .files![0]
                                                                .fileUrl
                                                                .isEmpty 
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                            child:
                                                                CachedNetworkImage(
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                    // CachedNetworkImage(
                                                                    //     imageUrl:
                                                                    //         'https://www.batnf.net/${news.files![index].thumbnail}',
                                                                    //     fit: BoxFit
                                                                    //         .cover),
                                                                    imageUrl:
                                                                        'https://www.batnf.net/${news.files![0].thumbnail}',
                                                                    fit: BoxFit
                                                                        .cover),
                                                          )
                                                        :
                                                        news.files![0]
                                                                    .fileExt ==
                                                                'video\/mp4'
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18),
                                                                child: controller
                                                                        !.value
                                                                        .isInitialized
                                                                    ? AspectRatio(
                                                                        aspectRatio: controller
                                                                            !.value
                                                                            .aspectRatio,
                                                                        child: CachedVideoPlayer(
                                                                            controller!))
                                                                    : Center(
                                                                        child:
                                                                            const CircularProgressIndicator()),
                                                              )
                                                            :
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                            child: CachedNetworkImage(
                                                              errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            CachedNetworkImage(
                                                                              imageUrl: 'https://www.batnf.net/${news.files![index].thumbnail}',
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                        placeholder: (context,
                                                                                url) =>
                                                                            Center(
                                                                              child: Text('Loading...'),
                                                                            ),
                                                                imageUrl:
                                                                    'https://www.batnf.net/${news.files![index].fileUrl}',
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.0),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
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
                                                          Text(
                                                            news.information,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                kBodyTextStyle,
                                                          ),
                                                          Text(
                                                            news.entryDate,
                                                            textAlign:
                                                                TextAlign.left,
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

                  // Visit Market Link
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 50.0),
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
                            image: AssetImage('assets/market.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
