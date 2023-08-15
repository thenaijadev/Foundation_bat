import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: const TextWidget(
            text: "Contact Us",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.mail),
                SizedBox(
                  width: 15,
                ),
                TextWidget(
                  text: "Email Address",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const TextWidget(text: "BATNF_Foundation@bat.com"),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Icon(Icons.location_on_rounded),
                SizedBox(
                  width: 15,
                ),
                TextWidget(
                  text: "Postal Address",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const TextWidget(
                text:
                    "BAT Nigeria Foundation, 2, Olumegbon Street Ikoyi, Lagos State, Nigeria."),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 15,
                ),
                TextWidget(
                  text: "Telephone",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const TextWidget(text: "(+234) 7046002033"),
            const SizedBox(
              height: 10,
            ),
            const TextWidget(text: "(+234) 7046002000"),
            const SizedBox(
              height: 30,
            ),
            const TextWidget(
                text: "Follow us across our social media pages for updates"),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Image.asset("assets/images/facebook.png"),
                const SizedBox(width: 25),
                Image.asset("assets/images/twitter.png"),
                const SizedBox(width: 25),
                Image.asset("assets/images/insta.png"),
                const SizedBox(width: 25),
                Image.asset("assets/images/youtube.png"),
                const SizedBox(width: 25),
                Image.asset("assets/images/linkedin.png"),
                const SizedBox(width: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
