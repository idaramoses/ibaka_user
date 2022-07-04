import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onproperty/theming/theme_manager.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:provider/provider.dart';

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
                  '${FirebaseAuth.instance.currentUser.displayName}',
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
                onTap: () => showDialog(
                    context: context,
                    builder: (ctx) => Consumer<ThemeNotifier>(
                        builder: (context, theme, child) => MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: theme.getTheme(),
                            home: Container(
                                child: SimpleDialog(
                              title: const Text('Change Theme'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    theme.setLightMode();
                                  },
                                  child: const Text('Light Theme'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    theme.setDarkMode();
                                  },
                                  child: const Text('Dark Theme'),
                                ),
                              ],
                            ))))),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.brightness_4_outlined,
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Change Theme',
                        style: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
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
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.8)),
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
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
              drawerTile(
                  title: 'Become Agents',
                  svgIconLoc: 'assets/icons/agents.svg',
                  routeName: 'AddProperty'),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
              drawerTile(
                  title: 'News and Blog',
                  svgIconLoc: 'assets/icons/news_and_blog.svg',
                  routeName: 'NewsAndBlog'),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
              drawerTile(
                  title: 'About Us',
                  svgIconLoc: 'assets/icons/about_us.svg',
                  routeName: 'AboutUs'),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
              drawerTile(
                  title: 'Contact Us',
                  svgIconLoc: 'assets/icons/contact_us.svg',
                  routeName: 'ContactUs'),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
              ),
              drawerTile(
                  title: 'Terms and Policies',
                  svgIconLoc: 'assets/icons/terms_and_privacy.svg',
                  routeName: 'TermsAndConditions'),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.4),
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
                  showDialog(
                    barrierColor: Colors.black26,
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        title: "Log out",
                        description: "Do you want to logout?.",
                      );
                    },
                  );
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
              color: Theme.of(context).accentColor.withOpacity(0.4),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.8)),
            )
          ],
        ),
      ),
    );
  }
}

//custom_alert_dialog.dart

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key key,
    this.title,
    this.description,
  }) : super(key: key);

  final String title, description;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Text(
            "${widget.title}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text("${widget.description}"),
          SizedBox(height: 20),
          Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                signOut();
              },
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
}
