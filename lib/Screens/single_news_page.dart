// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';

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
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<NewsProvider>(context, listen: false)
                .getAllNews();
          },
          child: ListView(
            children: [

              //News title
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

              //News Image
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 30),
                child: CachedNetworkImage(
                  imageUrl: 'https://www.batnf.net/${widget.singleNews.newsImage}',
                  fit: BoxFit.cover,
                ),
              ),

              // New Details
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
       
      ),
    );
  }
}