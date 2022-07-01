import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onproperty/components/carousal.dart';
import 'package:onproperty/components/textfield_with_filter.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/constants.dart';

import 'house_details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int galleryCount = 10;
  bool loadingMore = false;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldWithFilter(context: context),
            appCarousal(context),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Projects',
                    style: kh3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'SeeAllScreen');
                    },
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('property')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No House",
                                  style: TextStyle(),
                                ),
                              );
                            }

                            return Row(
                              children: [
                                NotificationListener(
                                  onNotification:
                                      (ScrollEndNotification notification) {
                                    if (notification is ScrollEndNotification &&
                                        scrollController.position.extentAfter ==
                                            0) {
                                      print("end");

                                      setState(() {
                                        loadingMore = true;
                                      });
                                      loadMore();
                                    }
                                    return false;
                                  },
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: 2,
                                      controller: scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        Map data =
                                            snapshot.data.docs[index].data();
                                        List<DocumentSnapshot> posts =
                                            snapshot.data.docs;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            margin: EdgeInsets.only(right: 8.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Container(
                                              height: 230,
                                              width: 180,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HouseDetails(
                                                            data,
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                .reference,
                                                          ),
                                                        ),
                                                      )
                                                          .then((value) {
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 150,
                                                      child: CachedNetworkImage(
                                                        placeholder:
                                                            (context, s) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                            ),
                                                          );
                                                        },
                                                        imageUrl:
                                                            data['cover_image'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${data['sell_type']}',
                                                          style: kh4,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          '${data['address']}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        IntrinsicHeight(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                '${data['bedroom_numbers']} ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                'bds ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              VerticalDivider(
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Text(
                                                                ' ${data['bathroom_numbers']}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                'baths  ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              VerticalDivider(
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Text(
                                                                ' ${data['area']}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                'sqft',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 7,
                                                                ),
                                                                Text(
                                                                  '${data['price']}',
                                                                  style: TextStyle(
                                                                      color:
                                                                          primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          11),
                                                                )
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            StreamBuilder<
                                                                DocumentSnapshot>(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "favourites")
                                                                  .doc("house")
                                                                  .collection(
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser
                                                                          .uid)
                                                                  .doc(posts[
                                                                          index]
                                                                      .id)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snap) {
                                                                if (snap.data ==
                                                                    null) {
                                                                  return SizedBox
                                                                      .shrink();
                                                                }
                                                                return IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (!snap
                                                                        .data
                                                                        .exists)
                                                                      addToFav(
                                                                          posts[
                                                                              index]);
                                                                    else
                                                                      removeFromFav(
                                                                          posts[
                                                                              index]);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: !snap
                                                                            .data
                                                                            .exists
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .red,
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                loadingMore
                                    ? Center(
                                        child: SpinKitThreeBounce(
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      )
                                    : SizedBox.shrink()
                              ],
                            );
                          } else {
                            return Center(
                              child: Text("Loading..."),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 30.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Properties Near You',
                    style: kh3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'SeeAllScreen');
                    },
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 350,
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('property')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return Center(
                          child: Text(
                            "No House",
                            style: TextStyle(),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          NotificationListener(
                            onNotification:
                                (ScrollEndNotification notification) {
                              if (notification is ScrollEndNotification &&
                                  scrollController.position.extentAfter == 0) {
                                print("end");

                                setState(() {
                                  loadingMore = true;
                                });
                                loadMore();
                              }
                              return false;
                            },
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Map data = snapshot.data.docs[index].data();
                                  List<DocumentSnapshot> posts =
                                      snapshot.data.docs;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, left: 8.0, right: 8.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CachedNetworkImage(
                                                placeholder: (context, s) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.grey,
                                                    ),
                                                  );
                                                },
                                                imageUrl: data['cover_image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0,
                                                      right: 8.0,
                                                      left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        '${data['price']}',
                                                        style: kh2,
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        '${data['address']}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${data['bedroom_numbers']} ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              'bds ',
                                                            ),
                                                            VerticalDivider(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              ' ${data['bathroom_numbers']} ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              'baths ',
                                                            ),
                                                            VerticalDivider(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Text(
                                                              '${data['area']} ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              'sqft',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              maxRadius: 5,
                                                              backgroundColor:
                                                                  Colors.green,
                                                            ),
                                                            Text(
                                                              '${data['sell_type']}',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Spacer(),
                                                            StreamBuilder<
                                                                DocumentSnapshot>(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "favourites")
                                                                  .doc("house")
                                                                  .collection(
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser
                                                                          .uid)
                                                                  .doc(posts[
                                                                          index]
                                                                      .id)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snap) {
                                                                if (snap.data ==
                                                                    null) {
                                                                  return SizedBox
                                                                      .shrink();
                                                                }
                                                                return IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (!snap
                                                                        .data
                                                                        .exists)
                                                                      addToFav(
                                                                          posts[
                                                                              index]);
                                                                    else
                                                                      removeFromFav(
                                                                          posts[
                                                                              index]);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: !snap
                                                                            .data
                                                                            .exists
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .red,
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          loadingMore
                              ? Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      );
                    } else {
                      return Center(
                        child: Text("Loading..."),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 5;
      loadingMore = false;
    });
  }

  void addToFav(DocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection("favourites")
        .doc("house")
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc(documentSnapshot.id)
        .set(Map.from(documentSnapshot.data()));
    Fluttertoast.showToast(msg: "Added to favourites");
  }

  void removeFromFav(DocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection("favourites")
        .doc("house")
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc(documentSnapshot.id)
        .delete();
    Fluttertoast.showToast(msg: "Removed from favourites");
  }
}
