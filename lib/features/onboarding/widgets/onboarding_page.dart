import 'package:batnf/router/routes.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit
                        .fill, // You can choose how the image fits inside the container
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        child: const TextWidget(
                          text: "Skip",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 300,
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .45,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: title,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      text: description,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                      color: const Color(0xFF6D6265),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
