import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onproperty/utils/colorscheme.dart';

import 'auth/auth_screen.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AuthScreen()),
            (Route<dynamic> route) => false);
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

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 10.0),
            color: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 60,
                  backgroundImage: AssetImage('assets/images/john.jpg'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Idara Moses',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Uyo,Akwa Ibom State',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'Settings');
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 15,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/profile.svg',
                          color: dividerTextColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(color: dividerTextColor),
                      )
                    ],
                  ),
                ),
              ),
              // Divider(
              //   color: Colors.black26,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => DashBoard(page: 2)),
              //     );
              //   },
              //   child: Container(
              //     height: 40,
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 10,
              //         ),
              //         SvgPicture.asset(
              //           'assets/icons/favourite.svg',
              //           color: dividerTextColor,
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           'Favourites',
              //           style: TextStyle(color: dividerTextColor),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Divider(
                color: Colors.black26,
              ),
              drawerTile(
                  title: 'Become Agents',
                  svgIconLoc: 'assets/icons/agents.svg',
                  routeName: 'AddProperty'),
              Divider(
                color: Colors.black26,
              ),
              drawerTile(
                  title: 'News and Blog',
                  svgIconLoc: 'assets/icons/news_and_blog.svg',
                  routeName: 'NewsAndBlog'),
              Divider(
                color: Colors.black26,
              ),
              drawerTile(
                  title: 'About Us',
                  svgIconLoc: 'assets/icons/about_us.svg',
                  routeName: 'AboutUs'),
              Divider(
                color: Colors.black26,
              ),
              drawerTile(
                  title: 'Contact Us',
                  svgIconLoc: 'assets/icons/contact_us.svg',
                  routeName: 'ContactUs'),
              Divider(
                color: Colors.black26,
              ),
              drawerTile(
                  title: 'Terms and Policies',
                  svgIconLoc: 'assets/icons/terms_and_privacy.svg',
                  routeName: 'TermsAndConditions'),
              Divider(
                color: Colors.black26,
              ),
              // drawerTile(
              //     title: 'Settings',
              //     svgIconLoc: 'assets/icons/setting.svg',
              //     routeName: 'Settings'),
              // Divider(
              //   color: Colors.black26,
              // ),
              InkWell(
                onTap: () {
                  signOut();
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icons/logout.svg',
                        color: Colors.red.shade400,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red.shade400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      )),
    );
  }

  drawerTile({String title, String svgIconLoc, String routeName}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              svgIconLoc,
              color: dividerTextColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: dividerTextColor),
            )
          ],
        ),
      ),
    );
  }
}
