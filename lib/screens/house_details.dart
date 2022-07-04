import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/constants.dart';

import 'chart/chat_details.dart';

class HouseDetails extends StatefulWidget {
  final Map data;

  final DocumentReference ref;

  HouseDetails(this.data, this.ref);
  @override
  _HouseDetailsState createState() => _HouseDetailsState();
}

List<String> prices = [
  'N567,900',
  'N335,900',
  'N289,700',
  'N470,000',
  'N224,670',
  'N490,270',
  'N300,600',
  'N651,230',
  'N980,000',
  'N300,000',
];
List<String> addresses = [
  '16 Oron road,Uyo, Akwa Ibom State',
  'Sheter Afrique Oron road,Uyo, Akwa Ibom State',
  '129 Oron road,Ikot Epene, Akwa Ibom State',
  '13598 Lagrone St,ikeja ,Lagos state',
  '4625 Careyback Ave,kubwa,Abuja',
  '4592 Oron road,Ikot Epene, Calaba',
  '4028 Timber Creek Dr, Ph,Rivers State',
  '11456 Oron road,Ikot Epene, Calaba',
  '67 Lagrone St,ikoji ,Lagos state',
  '24019 Doverwick Dr Tomball,Tx'
];
List<String> houseImg = [
  'assets/images/house.jpg',
  'assets/images/house1.jpg',
  'assets/images/house2.jpg',
  'assets/images/house3.jpg',
  'assets/images/house4.jpg',
  'assets/images/house5.jpg',
  'assets/images/house6.jpg',
  'assets/images/house7.jpg',
  'assets/images/house8.jpg',
  'assets/images/house9.jpg'
];

class _HouseDetailsState extends State<HouseDetails> {
  bool selected = false;
  int currentIndex = 0;
  int currentPostId = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.data['images'].length,
                          onPageChanged: (value) {
                            setState(() {
                              currentIndex = value;
                              currentPostId = widget.data['house_id'];
                            });
                          },
                          itemBuilder: (context, index) {
                            String image = widget.data['images'][index];
                            int current_index = index + 1;

                            return Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.black,
                                      builder: (context) {
                                        return Container(
                                          // height: 500,
                                          child: PageView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.data['images'].length,
                                            onPageChanged: (value) {
                                              setState(() {
                                                currentIndex = value;
                                                currentPostId =
                                                    widget.data['house_id'];
                                              });
                                            },
                                            itemBuilder: (context, index) {
                                              String image =
                                                  widget.data['images'][index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: InkWell(
                                                  child: CachedNetworkImage(
                                                    placeholder: (_, string) {
                                                      return Container(
                                                        height: 500,
                                                        child: Center(
                                                          child:
                                                              SpinKitThreeBounce(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    imageUrl: image,
                                                    // fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 520,
                                      child: CachedNetworkImage(
                                        placeholder: (_, string) {
                                          return Container(
                                            height: 500,
                                            child: Center(
                                              child: SpinKitThreeBounce(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                size: 30,
                                              ),
                                            ),
                                          );
                                        },
                                        alignment: Alignment.topCenter,
                                        imageUrl: image,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 20,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: primaryColor
                                                  .withOpacity(0.5)),
                                          child: Center(
                                            child: Text(
                                              '$current_index/${widget.data['images'].length}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: primaryColor),
                          child: Center(
                              child: Text(
                            '${widget.data['sell_type']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.data['title']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.data['address']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SvgPicture.asset(
                              'assets/icons/squareft.svg',
                              color: Colors.white,
                            ),
                            Text(
                              '${widget.data['area']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: MediaQuery.of(context).size.height * 0.32,
                  //   left: MediaQuery.of(context).size.width - 50,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         selected = !selected;
                  //       });
                  //     },
                  //     child: CircleAvatar(
                  //       backgroundColor: Colors.grey,
                  //       child: CircleAvatar(
                  //         child: selected
                  //             ? Icon(
                  //                 Icons.favorite,
                  //                 color: primaryColor,
                  //               )
                  //             : Icon(
                  //                 Icons.favorite_border,
                  //                 color: primaryColor,
                  //               ),
                  //         backgroundColor: Colors.grey[100],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      '${widget.data['price']}',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                    ),
                    Container(
                      height: 80,
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/bed.svg',
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data['bedroom_numbers']} beds',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VerticalDivider(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/washroom.svg',
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data['bathroom_numbers']} baths',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VerticalDivider(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/kitchen.svg',
                                    height: 20,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '2 kitchens',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8.0),
                // height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: kh1,
                    ),
                    Text(
                      '${widget.data['description']}',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                    )
                  ],
                ),
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Photos',
                        style: kh1,
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.data['images'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String image = widget.data['images'][index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.black,
                                    builder: (context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: CachedNetworkImage(
                                                placeholder: (_, string) {
                                                  return SpinKitThreeBounce(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    size: 30,
                                                  );
                                                },
                                                imageUrl: image,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 0,
                                              right: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Text(
                                                  '${widget.data["title"]}',
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: CachedNetworkImage(
                                placeholder: (_, string) {
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      color: Theme.of(context).accentColor,
                                      size: 30,
                                    ),
                                  );
                                },
                                imageUrl: image,
                                width: MediaQuery.of(context).size.width * .5,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: kh1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: CircleAvatar(
                        maxRadius: 45,
                        backgroundImage:
                            AssetImage('assets/images/person2.jpeg'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      widget.data['user_name'],
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                    // Center(
                    //     child: Text(
                    //   'Takaful Real Estate',
                    //   style: TextStyle(color: Colors.black, fontSize: 14),
                    // )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Theme.of(context).backgroundColor),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Chat(
                                    peername: '${widget.data['user_name']}',
                                    peerId: '${widget.data['user_id']}',
                                    userId: '${widget.data['user_id']}',
                                    houseId: '${widget.data['house_id']}',
                                    peerAvatar: 'private',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: primaryColor,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Message',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
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
  }

  houseDetailsList() {
    return ListView.builder(
        itemCount: houseImg.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              index == 0
                  ? SizedBox(
                      width: 8,
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      margin:
                          EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 140,
                        margin: EdgeInsets.only(right: 8.0),
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(right: 6),
                                height: double.infinity,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(houseImg[index]))),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prices[index],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.place,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          Text(
                                            addresses[index],
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Text(
                                            '3 ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'bds ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          VerticalDivider(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            '5 ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'baths ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          VerticalDivider(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            '1750 ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'sqft',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Agent: ',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Chapman Ford',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        Icon(Icons.star,
                                            size: 16, color: Colors.orange),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          '(0 Reviews)',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          );
        });
  }
}
