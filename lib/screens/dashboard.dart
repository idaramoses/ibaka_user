import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onproperty/components/notification_icon.dart';
import 'package:onproperty/screens/chat.dart';
import 'package:onproperty/screens/home.dart';
import 'package:onproperty/screens/profile.dart';
import 'package:onproperty/screens/search_properties.dart';
import 'package:onproperty/screens/search_property.dart';
import 'package:onproperty/screens/wishlist.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/images.dart';

import 'chart/chat.dart';
import 'main_profile.dart';

class DashBoard extends StatefulWidget {
  final int page;

  DashBoard({this.page = 0});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();
  int _currentTab = 0;
  Widget currentScreen = Home();
  String title;

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),
        // drawer: CustomDrawer(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentTab,
          onItemSelected: (index) {
            setState(() => _currentTab = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: ColorResources.COLOR_PRIMARY,
                inactiveColor: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
                title: Text('Home'),
                icon: Icon(Icons.home)),
            BottomNavyBarItem(
                activeColor: ColorResources.COLOR_PRIMARY,
                inactiveColor: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
                title: Text('Search'),
                icon: Icon(Icons.search)),
            BottomNavyBarItem(
                activeColor: ColorResources.COLOR_PRIMARY,
                inactiveColor: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
                title: Text('Favourite'),
                icon: Icon(Icons.favorite)),
            BottomNavyBarItem(
                activeColor: ColorResources.COLOR_PRIMARY,
                inactiveColor: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
                title: Stack(
                  children: [
                    Text('Chat'),
                    Positioned(
                      top: 0,
                      right: 0.0,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("usersChatActivity")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection('activity')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data.docs.length == 0) {
                              return SizedBox.shrink();
                            } else
                              return Container(
                                // height: 15,
                                // width: 15,
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Center(
                                    child: Text(
                                  snapshot.data.docs.length.toString(),
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              );
                          }),
                    ),
                  ],
                ),
                icon: Icon(Icons.chat)),
            BottomNavyBarItem(
                activeColor: ColorResources.COLOR_PRIMARY,
                inactiveColor: ColorResources.COLOR_PRIMARY.withOpacity(0.7),
                title: Text('Profile'),
                icon: Icon(Icons.account_circle)),
          ],
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Home(),
              SearchProperty(),
              Wishlist(),
              MainChat(),
              MainProfile(),
            ],
          ),
        ),
      ),
    );
  }

  /*........................................Bottom Navigation bar.......................*/
  BottomAppBar customBottomNavigationBar() {
    return BottomAppBar(
      child: Container(
        height: 55,
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = Home();
                  _currentTab = 0;
                  title = 'Hello, Idara Moses';
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/home.svg',
                      color: _currentTab == 0 ? primaryColor : Colors.grey)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = SearchProperties();
                  _currentTab = 1;
                  title = 'Projects';
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/building.svg',
                      color: _currentTab == 1 ? primaryColor : Colors.grey)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = Wishlist();
                  _currentTab = 2;
                  title = 'Wishlist';
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/heart.svg',
                      color: _currentTab == 2 ? primaryColor : Colors.grey)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = Chat();
                  _currentTab = 3;
                  title = 'Chat';
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/chat.svg',
                      color: _currentTab == 3 ? primaryColor : Colors.grey)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = Profile();
                  _currentTab = 4;
                  title = 'Profile';
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/profile.svg',
                      color: _currentTab == 4 ? primaryColor : Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  /*........................................Custom AppBar.....................*/
  AppBar customAppBar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      leading: Image.asset(
        Images.logo_with_name_image,
        // height: 80,
        width: 150,
      ),
      actions: [
        // locationIcon(context),
        notificationIcon(context),
      ],
    );
  }
}
