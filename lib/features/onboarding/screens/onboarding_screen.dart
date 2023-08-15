import 'package:batnf/features/onboarding/widgets/onboarding_page.dart';
import 'package:batnf/router/routes.dart';
import 'package:batnf/universal.dart/main_btn.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  // ignore: unused_field
  int _currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  // Dummy data for onboarding pages (you can replace this with your content)
  final List<Widget> _pages = [
    const OnboardingPageWidget(
      image: "assets/images/events.jpg",
      title: "Attend our events",
      description:
          "Keep up to date with our events as they happen.Don't forget to register so that you can be part of our stories as we continue to make a difference.",
    ),
    const OnboardingPageWidget(
      image: "assets/images/news.jpg",
      title: "News Updates",
      description:
          "Get live updates on the foundation's activities, press statements, news articles, videos and photos.",
    ),
    const OnboardingPageWidget(
      image: "assets/images/projects.jpg",
      title: "Explore our projects",
      description:
          "Our agricultural initiatives are aimed at empowering small holder farmers to improve their productivity and help build their capacity to establish viable agricultural enterprises. ",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                    controller: pageController, // PageController
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Color.fromARGB(255, 8, 51, 121),
                    ), // your preferred effect
                    onDotClicked: (index) {}),
              )),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: MainButton(
                label: _currentPage == 2 ? "Get Started" : "Next",
                onTap: () {
                  if (_currentPage == 2) {
                    Navigator.pushReplacementNamed(context, Routes.login);
                    return;
                  }
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
