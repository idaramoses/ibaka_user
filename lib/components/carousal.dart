import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

appCarousal(BuildContext context) {
  ScreenUtil.init(context, width: 1080, height: 1920);
  return Container(
    height: MediaQuery.of(context).size.height * 0.30,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    margin: EdgeInsets.only(top: 18.0, left: 8.0, right: 8.0, bottom: 18.0),
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('slider')
          // .orderBy("order", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .33,
            child: Swiper(
              autoplay: true,
              itemCount: snapshot.data.docs.length,
              // itemWidth: MediaQuery.of(context).size.height * .33,
              viewportFraction: 0.9,
              scale: 0.9,
              itemBuilder: (context, _currentIndex) {
                Map data = snapshot.data.docs[_currentIndex].data();
                // DateTime mydateTime = data['created'].toDate();
                // String formattedTime =
                //     DateFormat.yMMMd().add_jm().format(mydateTime);
                var currentindex = _currentIndex;
                return InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, "/${data['sliderlocation']}");
                  },
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: CachedNetworkImage(
                            imageUrl: "${data['sliderimage']}",
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * .33,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Loading..."),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    ),
  );
}
