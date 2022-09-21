// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

  @override
  void initState() {
    super.initState();
    var of = Provider.of<NewsProvider>(context, listen: false);
    of.getAllNews();
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: kBackground,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 142),
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
                              FontAwesomeIcons.solidBell,
                              size: 15,
                              color: kButtonColor),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  if (provider.allNews != null &&
                      provider.allNews!.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
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
              child: provider.allNews == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allNews!.isEmpty
                      ? Center(
                          child: Text('No Latest News'),
                        )
                      : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.allNews!.length,
                  itemBuilder: ((context, index) {
                  NewsModel news = provider.allNews![index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewsDetails(news)));
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
                            Container(
                              height: 110,
                              width: 110,
                              margin:
                                  EdgeInsets.only(bottom: 7.0, top: 7.0, left: 9.0),
                              child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                'https://portswigger.net/cms/images/63/12/0c8b-article-211117-linux-rng.jpg',
                                            fit: BoxFit.cover),
                                      ),
                            ),
                            Expanded(
                              child: Container(
                                height: 93,
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 10, left: 10.0, right: 6.0),
                                color: kBackground,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Container(
                                      color: kBackground,
                                      height: 19,
                                      child: Text(
                                        news.title,
                                        style: kNewsSubHeader,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          // margin: EdgeInsets.only(bottom: 4.0),
                                          color: kBackground,
                                          height: 7.0,
                                          child: Text(
                                            news.information,
                                            textAlign: TextAlign.left,
                                            style: kBodyTextStyle,
                                          )),
                                    ),
                                    Text(
                                      news.entryDate,
                                      textAlign: TextAlign.left,
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
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
