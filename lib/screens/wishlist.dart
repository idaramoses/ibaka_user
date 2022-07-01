import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onproperty/utils/constants.dart';

import 'house_details.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int galleryCount = 10;
  bool loadingMore = false;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("favourites")
                  .doc("house")
                  .collection(FirebaseAuth.instance.currentUser.uid)
                  .limit(galleryCount)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No Wishlist House",
                        style: TextStyle(),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      NotificationListener(
                        onNotification: (ScrollEndNotification notification) {
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
                            itemCount: snapshot.data.docs.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              Map data = snapshot.data.docs[index].data();
                              List<DocumentSnapshot> posts = snapshot.data.docs;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => HouseDetails(
                                        data,
                                        snapshot.data.docs[index].reference,
                                      ),
                                    ),
                                  )
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5),
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
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 18.0,
                                                left: 8.0,
                                              ),
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
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  right: 8.0,
                                                  // left: 10,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                            '${data['bedroom_numbers']}',
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
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            '${data['bathroom_numbers']}',
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
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            '${data['area']}',
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            maxRadius: 5,
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                          Text(
                                                            ' House for Sale',
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
                                                                .doc(
                                                                    posts[index]
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
                                                                onPressed: () {
                                                                  if (!snap.data
                                                                      .exists)
                                                                    addToFav(posts[
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
