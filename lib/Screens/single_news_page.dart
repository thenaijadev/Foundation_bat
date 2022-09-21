// ignore_for_file: prefer_const_constructors

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsDetails extends StatefulWidget {
  
  final NewsModel singleNews;
  NewsDetails(this.singleNews, {Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kButtonColor),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    widget.singleNews.title,
                    style: kPageHeader,
                  ),
                  Text('Dec 21 2021')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 30),
              child: CachedNetworkImage(
                imageUrl:
                    'https://portswigger.net/cms/images/63/12/0c8b-article-211117-linux-rng.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
              child: Text(
                widget.singleNews.information,
                textAlign: TextAlign.justify,
                style: kBodyTextStyle,
              ),
            ),
          ],
        ),
       
      ),
    );
  }
}