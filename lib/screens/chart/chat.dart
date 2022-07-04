import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onproperty/screens/chart/chat_details.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:timeago/timeago.dart' as timeago;

class MainChat extends StatefulWidget {
  const MainChat({Key key}) : super(key: key);

  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  bool isInit = false;
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    //refresh();
    if (!isInit) {
      FirebaseFirestore.instance
          .collection("usersChatActivity")
          .doc('${FirebaseAuth.instance.currentUser.uid}')
          .collection('activity')
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));

      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          generalGroupList(),
        ],
      ),
    );
  }

  Widget generalGroupList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Chat_Col")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("MainChat")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data.docs.length == null) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data.docs.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                "No Chats.",
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map doc = snapshot.data.docs[index].data();
                  String dataid = snapshot.data.docs[index].id;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Container(
                          // color: Theme.of(context).backgroundColor,
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Chat(
                                      peername: doc["username"],
                                      houseId: doc['house_id'],
                                      userId: doc['mainId'],
                                      peerId: doc["userId"],
                                      peerAvatar: 'private',
                                    ),
                                  ),
                                );
                              },
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  placeholder: (context, s) {
                                    return Center(
                                      child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://cdn.logo.com/hotlink-ok/logo-social.png')))),
                                    );
                                  },
                                  imageUrl: doc["photo"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                "${doc["username"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: groupLastMessage(dataid,
                                  FirebaseAuth.instance.currentUser.uid),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  // Expanded(
                                  //     child: lastGroupMessageTime(
                                  //         dataid,
                                  //         FirebaseAuth
                                  //             .instance.currentUser.uid)),
                                  Expanded(
                                    child: groupChatCounter(doc['house_id']),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget groupLastMessage(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Pchat')
          .doc(groupId)
          .collection(groupId)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map doc = snapshot.data.docs[index].data();
                  String dataid = snapshot.data.docs[index].id;
                  // Group group = value.userGroups.reversed.toList()[index];
                  // Group group = Group(
                  //     id: int.parse(doc.docID),
                  //     name: doc.data["name"],
                  //     photo: doc.data["photo"],
                  //     description: doc.data["description"],
                  //     totalMembers: 0,
                  //     certificate: "",
                  //     type: "",
                  //     year: "",
                  //     schoolId: 0,
                  //     schoolName: "");

                  return RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: " ${doc["content"]}" ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                    maxLines: 1,
                  );
                },
              ),
            ],
          );
        } else
          return Text("");
      },
    );
  }

  Widget lastGroupMessageTime(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Pchat')
          .doc(groupId)
          .collection(groupId)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final fifteenAgo = snapshot.data.docs.last["timestamp"];

          // var now = DateTime.now();
          // var today = DateTime(now.year, now.month, now.day);
          // var yesterday = DateTime(now.year, now.month, now.day - 1);
          // Timestamp time = snapshot.data.docs.length < 1
          //     ? Timestamp.fromDate(DateTime.now())
          //     : snapshot.data.docs.last["timestamp"];
          //
          // var date = time != null ? time.toDate() : DateTime.now();
          // var formattedTime;
          //
          // if (DateTime(date.year, date.month, date.day) == today) {
          //   formattedTime = DateFormat('hh:mm a').format(date);
          // } else if (DateTime(date.year, date.month, date.day) == yesterday) {
          //   formattedTime = "Yesterday";
          // } else {
          //   formattedTime = DateFormat('yMd').format(date);
          // }

          return Text(
            snapshot.data.docs.length < 1
                ? ""
                : timeago.format(DateTime.tryParse(fifteenAgo)),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          );
        }
        return Text("");
      },
    );
  }

  Widget groupChatCounter(String groupId) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Pnoti')
            .doc("$groupId")
            .collection("messages")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("messages")
            .where("read", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return Container(
              child: snapshot.data.docs.length == 0
                  ? Text("")
                  : Container(
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setHeight(50),
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        child: Text(snapshot.data.docs.length.toString() ?? "",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(25),
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
            );
          return Text("");
        });
  }

  Future<List<DocumentSnapshot>> getGeneralGroups() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Chat")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("MainChat")
        .get();
    List<DocumentSnapshot> docs = qs.docs;
    return docs;
  }
}
