// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Models/news_model.dart';
import 'package:batnf/Screens/video_thumbnail.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class NewsDetails extends StatefulWidget {
  final NewsModel singleNews;
  NewsDetails(this.singleNews, {Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: BackButton(color: Theme.of(context).hintColor),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //News Image
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CarouselSlider(
                            
                              carouselController: _controller,
                              options: CarouselOptions(
                                autoPlayInterval: Duration(seconds: 10),
                                height: 265,
                                viewportFraction: 1.0,
                                  enableInfiniteScroll: false,
                                  padEnds: false,
                                // autoPlay: true
                              ),
                              items: widget.singleNews.files!.map((newsFile) {
                                if (newsFile.fileExt == '') {
                                  return CachedNetworkImage(
                                      imageUrl:
                                          'https://www.batnf.net/${newsFile.thumbnail}',
                                      fit: BoxFit.cover);
                                } else if (newsFile.fileExt == 'image' && newsFile.thumbnail.isNotEmpty) {
                                  return CachedNetworkImage(
                                      errorWidget: (context, url, error) => Center(
                                          child: Text('No Image/Video Available')),
                                      placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(),
                                          ),
                                      imageUrl:
                                          'https://www.batnf.net/${newsFile.fileUrl}',
                                      fit: BoxFit.cover);
                                }
                                return Videos(thumbnailUrl: newsFile.thumbnail, videoUrl: newsFile.fileUrl,);
                              }).toList())),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('previous'),
                          MaterialButton(
                            onPressed: () => _controller.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear),
                            child: Icon(FontAwesomeIcons.arrowLeft),
                          ),
                          MaterialButton(
                            onPressed: () => _controller.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear),
                            child: Icon(FontAwesomeIcons.arrowRight),
                          ),
                          Text('Next')
                        ],
                      )
                    ],
                  ),
                ),
        
                //News title
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 30,
                    right: 30,
                    bottom: 10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        widget.singleNews.title,
                        style: kSingletitle,
                      ),
                      SizedBox(height: 5,),
                      Text(widget.singleNews.entryDate,
                      style: kSinglestart,)
                    ],
                  ),
                ),
                // New Details
                Container(
                  margin:
                      EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                  child: ReadMoreText(
                    widget.singleNews.information,
                    textAlign: TextAlign.justify,
                    style: kBodyTextStyle,
                    trimLength: 150,
                    trimMode: TrimMode.Line,
                    trimLines: 15,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Show Less',
                    lessStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    moreStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
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
