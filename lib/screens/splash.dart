import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onproperty/screens/dashboard.dart';
import 'package:onproperty/screens/onboarding/onboardScreen.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/images.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        new Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => OnboardScreen()));
        });
      } else {
        new Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => DashBoard(
                    page: 0,
                  )));
        });
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isvisible = true;
      });
    });
  }

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          // image: DecorationImage(
          //     fit: BoxFit.cover, image: AssetImage('assets/images/house.jpg')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              height: 100,
            ),
            Image.asset(
              Images.logo_with_name_image,
              height: 150,
              width: 200,
            ),
            Spacer(),
            isvisible
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: primaryColor.withOpacity(0.5),
                    ),
                  )
                : SizedBox(
                    height: 30,
                  ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
