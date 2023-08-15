import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.name, this.width});
  final String name;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/$name",
      width: width,
    );
  }
}
