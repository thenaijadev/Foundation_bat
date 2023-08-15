import 'package:batnf/constants.dart/string.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white, width: 4),
          ),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
        child: Center(child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imagePlaceHolder, fit: BoxFit.cover,height: 120, width: 180))),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Icon(icon, color: Colors.white, size: 48),
        //     const SizedBox(height: 12),
        //     Text(
        //       label,
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
