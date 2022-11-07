// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batnf/Models/news_model.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:provider/provider.dart';
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
    NewsProvider provider = Provider.of<NewsProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container for search box etc
            Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: Theme.of(context).primaryColor,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 140),
                        color: Theme.of(context).primaryColor,
                        height: 29,
                        child: Text(
                          'News',
                          style: kPageHeader,
                        ),
                      ),
                    ],
                  ),
                  if (provider.allNews != null && provider.allNews!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                      color: Theme.of(context).primaryColor,
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
                          child: Image.asset('assets/noitem.png.gif'),
                        )
                      : RefreshIndicator(
                        color: kBackground,
                        backgroundColor: Theme.of(context).primaryColor,
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
                                  width: 368,
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30.0,
                                  ),
                                    color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 310,
                                        margin: EdgeInsets.only(
                                            bottom: 7.0, top: 7.0, left: 9.0),
                                        child: news.files!.first
                                                          .fileExt ==
                                                      'image/jpeg' &&
                                                  news.files!.first
                                                      .fileUrl.isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://www.batnf.net/${news.files!.first.fileUrl}',
                                                      fit: BoxFit.cover),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://www.batnf.net/${news.files!.first.thumbnail}',
                                                      fit: BoxFit.cover),
                                                ),
                                    ),
                                      // News Details
                                         
                                      Text(
                                        news.title,
                                        style: kNewsSubHeader,
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
          ],
        ),
        
      ),
    );
  }
}
