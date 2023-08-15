import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      this.textDirection,
      this.onTap});
  final ImageProvider<Object> image;
  final String title;
  final String subTitle;
  final TextDirection? textDirection;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: textDirection,
          children: [
            Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 190,
                    child: TextWidget(
                      text: subTitle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
