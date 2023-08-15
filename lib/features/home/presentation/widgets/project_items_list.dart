import 'package:batnf/features/home/presentation/widgets/news_item.dart';
import 'package:batnf/router/routes.dart';
import 'package:flutter/material.dart';

class ProjectItemsList extends StatelessWidget {
  const ProjectItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.projectDetails),
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
