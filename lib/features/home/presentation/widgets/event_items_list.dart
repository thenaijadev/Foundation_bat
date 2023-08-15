import 'package:batnf/features/home/presentation/widgets/news_item.dart';
import 'package:batnf/router/routes.dart';
import 'package:flutter/material.dart';

class EventItemsList extends StatelessWidget {
  const EventItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.eventDetails);
            },
            child: const NewsItem(
                textDirection: TextDirection.rtl,
                image: AssetImage(
                  "assets/images/events.jpg",
                ),
                title: "Farmers Market",
                subTitle:
                    "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
          ),
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
