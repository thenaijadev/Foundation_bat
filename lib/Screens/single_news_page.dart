// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
  }

  int index = 0;
  int index2 = 1;
  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    List<String> imgList = [
      'https://www.batnf.net/${widget.singleNews.files?[0].fileUrl}',
      // 'https://www.batnf.net/${widget.singleNews.files?[index2].fileUrl}',
      // ' https://www.batnf.net/news/blog-r-3.jpg',
      // 'https://www.batnf.net/${widget.singleNews.files?[1].fileUrl}',
    ].toList();
    // var myList = imgList;
    // //  var index = 0;
    // if (index > 0) {
    //  List<String> imgList = [
    //     'https://www.batnf.net/${widget.singleNews.files?[0].fileUrl}',
    //     'https://www.batnf.net/${widget.singleNews.files?[index2].fileUrl}',
    //     // ' https://www.batnf.net/news/blog-r-3.jpg',
    //     // 'https://www.batnf.net/${widget.singleNews.files?[1].fileUrl}',
    //   ].toList();
    //    // You can safely access the element here.
    // }
    NewsModel news = provider.allNews![index];

    final List<Widget> imageSliders = imgList
        .map((item) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child:CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      width: 365,
                    ),
            ))
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        // extendBodyBehindAppBar: true,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //News title
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
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
                  height: 300,
                  color: kButtonColor,
                  margin:
                      EdgeInsets.only(top: 20, left: 0, bottom: 20, right: 0),
                  child:
                      // ListView.builder(
                      //     itemCount:
                      //         widget.singleNews.files?[index].fileUrl.length,
                      //     itemBuilder: ((context, index) {
                      //       return CarouselSlider(
                      //         options: CarouselOptions(
                      //             autoPlayInterval: Duration(seconds: 10),
                      //             height: 350,
                      //             viewportFraction: 1.0,
                      //             enableInfiniteScroll: false,
                      //             autoPlay: true),
                      //         items: imageSliders,
                      //       );
                      //     }))
                       widget.singleNews.files![index = 0].fileUrl.isEmpty
                          ? CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  CachedNetworkImage(
                                      imageUrl:
                                          'https://www.batnf.net/${widget.singleNews.newsImage}',
                                      fit: BoxFit.cover),
                              imageUrl:
                                  'https://www.batnf.net/${widget.singleNews.newsImage}',
                              fit: BoxFit.cover)
                          : CarouselSlider(
                    options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 10),
                        height: 350,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: true),
                    items: imageSliders,
                  ),
                ),

                // New Details
                Container(
                  margin:
                      EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
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
      ),
    );
  }
}
