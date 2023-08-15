import 'package:batnf/router/routes.dart';
import 'package:batnf/universal.dart/main_btn.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({super.key, required this.message});
  final String message;

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/email.json',
            controller: _controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..repeat();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(
              text: widget.message,
              textAlign: TextAlign.center,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: MainButton(
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.login);
                },
                label: "Login"),
          )
        ],
      ),
    );
  }
}
