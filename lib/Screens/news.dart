// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batnf/Models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class News extends StatefulWidget {
  static String id = 'new';
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            top: 50, left: 10, bottom: 26, right: 140),
                        color: kBackground,
                        height: 29,
                        child: Text(
                          'News',
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
                  if (provider.allNews != null && provider.allNews!.isNotEmpty)
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
              child: provider.allNews == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allNews!.isEmpty
                      ? Center(
                          child: Text('No Latest News', style: kBodyTextStyle,),
                        )
                      : RefreshIndicator(
                        color: kBackground,
                        backgroundColor: kButtonColor,
                        onRefresh: ()async{
                           await Provider.of<NewsProvider>(context, listen: false)
                                .getAllNews();
                          },
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: provider.allNews!.length,
                            itemBuilder: ((context, index) {
                              NewsModel news = provider.allNews![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetails(news)));
                                },
                                child: Container(
                                  height: 124,
                                  width: 368,
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
                                      //News Image
                                      Container(
                                        height: 110,
                                        width: 110,
                                        margin: EdgeInsets.only(
                                            bottom: 7.0, top: 7.0, left: 9.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  news.newsImage,
                                              fit: BoxFit.cover),
                                        ),
                                      ),

                                      //News Details
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
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [

                                              //News Header
                                              Expanded(
                                                child: Container(
                                                  color: kBackground,
                                                  height: 20,
                                                  child: Text(
                                                    news.title,
                                                    style: kNewsSubHeader,
                                                  ),
                                                ),
                                              ),

                                              //News Information
                                              Expanded(
                                                child: Container(
                                                    color: kBackground,
                                                    height: 10,
                                                    child: Text(
                                                      textAlign: TextAlign.left,
                                                      news.information,
                                                      style: kBodyTextStyle,
                                                    )),
                                              ),

                                              // News Date
                                              Text(
                                                textAlign: TextAlign.left,
                                                news.entryDate,
                                                style: kNewsDateSTyle,
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
