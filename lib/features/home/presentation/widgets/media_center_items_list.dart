import 'package:batnf/features/home/presentation/widgets/news_item.dart';
import 'package:batnf/router/routes.dart';
import 'package:flutter/material.dart';

class MediaCenterItemsList extends StatelessWidget {
  const MediaCenterItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          NewsItem(
              onTap: () {
                Navigator.pushNamed(context, Routes.mediaItemsCenterDetails);
              },
              textDirection: TextDirection.rtl,
              image: const AssetImage(
                "assets/images/events.jpg",
              ),
              title: "Farmers Market",
              subTitle:
                  "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
          const NewsItem(
              textDirection: TextDirection.rtl,
              image: AssetImage(
                "assets/images/events.jpg",
              ),
              title: "Farmers Market",
              subTitle:
                  "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
          const NewsItem(
              textDirection: TextDirection.rtl,
              image: AssetImage(
                "assets/images/events.jpg",
              ),
              title: "Farmers Market",
              subTitle:
                  "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
          const NewsItem(
              textDirection: TextDirection.rtl,
              image: AssetImage(
                "assets/images/events.jpg",
              ),
              title: "Farmers Market",
              subTitle:
                  "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
        ],
      ),
    );
  }
}
