import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({super.key, required this.label, required this.icon});
  final String label;
  final Widget icon;
  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0x4CD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: widget.label,
                fontSize: 20,
              ),
              widget.icon
            ],
          ),
        ),
      ),
    );
  }
}
