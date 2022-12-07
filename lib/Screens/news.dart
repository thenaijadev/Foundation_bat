// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batnf/Models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme_provider.dart';
import '../widgets/change_theme_button.dart';


class News extends StatefulWidget {
  static String id = 'new';
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  //This provider doesn;t listen.
  //I use it for making requests and for
  //reading values in initstate
  late NewsProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<NewsProvider>(context, listen: false);

    //I check if the provider is null or empty before getting the news.
    //You know you already make the request in homepage.
    //So if it is not null, no need to get news every time this page is opened.

    //If the user wants latest news, the person can use the refresh function you added.
    if (_provider.allNews == null || _provider.allNews!.isEmpty) {
      _provider.getAllNews();
    }
    super.initState();
  }
  Future<bool> onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: Text('Exist App'),
          content: Text('Do you want to Exit app ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes')),
          ],
        );
      }),
    );
    return exitApp ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';
    NewsProvider provider = Provider.of<NewsProvider>(context);

    //In the body, I used the searchResult in the news provider class instead of the allNews you created.
    //Check the provider class for explanation.

    //On another note, i removed your back button because it;s
    //no longer necessary. I am not moving users to a new page, i am only changing
    //the index of the bottom nav bar. Check homepage for explanation.
    return WillPopScope(
      onWillPop: () async => onBackButtonPressed(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 60,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    
              // App Logo
              actions: [
                Container(
                  margin: EdgeInsets.only(left: 24.0, top: 10, bottom: 10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 40.0,
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, left: 10, bottom: 6, right: 130),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 29,
                  child: Text(
                    'News',
                    style: kPageHeader,
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
                      size: 20,
                      FontAwesomeIcons.bars,
                      color: Theme.of(context).primaryColor,
                    ));
              })),
          // Drawer
          drawer: Drawer(
            width: 250,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // UserAccountsDrawerHeader(
                //   accountName: Text(),
                //   accountEmail: Text('email'),
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
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ResetPassword.id);
                  },
                  child: ListTile(
                      title: Text(
                        'Change Password',
                        style:
                            TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      leading: Icon(FontAwesomeIcons.userLock,
                          color: Theme.of(context).primaryColor)),
                ),
    
                //Logout option
                InkWell(
                  onTap: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('autoLogin', false);
    
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignIn.id, (Route<dynamic> route) => false);
                  },
                  child: ListTile(
                      title: Text(
                        'LogOut',
                        style:
                            TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      leading: Icon(FontAwesomeIcons.signOutAlt,
                          color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container for search box etc
              
              if (provider.searchResult != null && provider.searchResult!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(left: 30, right: 20, bottom: 21, top: 15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 45.0,
                  child: TextField(
                    onChanged: ((value) {
                      //this is where i am making the call to the search function
                      //i created in the newsprovider class. Remember that i am using a
                      //provider whose listener is set to false because i dont want to get
                      //updates here. I only want to call the function and not listen to the
                      //result of my call.
                      _provider.search(value);
                    }),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 2),
                      hintText: 'e.g: News Title',
                      hintStyle: kSearchboxhintstyle,
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
    
              ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: Expanded(
                  child: provider.searchResult == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : provider.searchResult!.isEmpty
                          ? Center(
                              child: Image.asset('assets/noitem.png.gif'),
                            )
                          : RefreshIndicator(
                              color: kGeneralbodytextColor,
                              backgroundColor: Theme.of(context).primaryColor,
                              onRefresh: () async {
                                await _provider.getAllNews();
                              },
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: provider.searchResult!.length,
                                  itemBuilder: ((context, index) {
                                    NewsModel news = provider.searchResult![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsDetails(news)));
                                      },
                                      child: Container(
                                        width: 368,
                                        margin: EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          bottom: 30.0,
                                        ),
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            //Images
                                            Container(
                                              height: 150,
                                              width: 310,
                                              decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius
                                                        .circular(18)),
                                              margin: EdgeInsets.only(
                                                  bottom: 7.0, top: 7.0, left: 9.0),
                                              child:
                                              news.files!.isEmpty
                                                  ? Image.asset(
                                                        'assets/logo.png')
                                                  :   news.files!.first
                                                                    .fileExt ==
                                                                'image/jpeg' &&
                                                            news
                                                                .files!
                                                                .first
                                                                .fileUrl
                                                                .isNotEmpty
                                                            ? CachedNetworkImage(
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Center(
                                                                  child: Icon(
                                                                    Icons.error,
                                                                  ),
                                                                ),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                            imageUrl:
                                                                'https://www.batnf.net/${news.files!.first.fileUrl}',
                                                            fit: BoxFit.cover)
                                                             : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                            child:
                                                                CachedNetworkImage(
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
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                    imageUrl:
                                                                        'https://www.batnf.net/${news.files!.first.thumbnail}',
                                                                    fit: BoxFit
                                                                        .cover),
                                                          ) 
                                            ),
                  
                                            // News Details
                                            Text(
                                              news.title,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: 'Inter',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              // kNewsSubHeader,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
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
