import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onproperty/screens/auth/auth_screen.dart';

import 'Intro_screen.dart';
import 'OnboradingData.dart';

class OnboardScreen extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "assets/images/ob_1.png",
      title: "Search Houses Near You",
      desc: "Discover houses near you both commercial and residential,",
    ),
    OnbordingData(
      imagePath: "assets/images/ob_2.png",
      title: "Trusted Agents",
      desc: "Our Agents are trusted and reliable",
    ),
    OnbordingData(
      imagePath: "assets/images/ob_3.png",
      title: "Top rated properties",
      desc:
          "Top rated Real Estate Homes and Properties available for you to choose.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new IntroScreen(
        list,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      ),
    );
  }
}
