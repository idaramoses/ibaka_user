import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onproperty/components/home_componets.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/constants.dart';

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

firstHalf(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.40,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(bottom: 10.0),
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          maxRadius: 60,
          backgroundImage: AssetImage('assets/images/john.jpg'),
        ),
        Text(
          'Idara Moses',
          style: kh1,
        ),
        Text(
          'Uyo,Akwa Ibom State',
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ContactUs');
          },
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: primaryColor),
            child: Center(
              child: Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
        //   child:  Divider(
        //         color: Theme.of(context).accentColor.withOpacity(0.4),
        //       ),
        // ),
        // Container(
        //   height: 40,
        //   width: double.infinity,
        //   margin: EdgeInsets.symmetric(horizontal: 30),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.pushNamed(context, 'Followers');
        //         },
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               '500',
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               'Followers',
        //               style: TextStyle(color: Colors.grey),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         width: 30,
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.pushNamed(context, 'Properties');
        //         },
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               '60',
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               'Properties',
        //               style: TextStyle(color: Colors.grey),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         width: 30,
        //       ),
        //       GestureDetector(
        //         onTap: () => Navigator.pushNamed(context, 'Following'),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               '60',
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               'Followings',
        //               style: TextStyle(color: Colors.grey),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
        //   child:  Divider(
        //         color: Theme.of(context).accentColor.withOpacity(0.4),
        //       ),
        // ),
      ],
    ),
  );
}

anotherList() {
  return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return index == 0
            ? firstHalf(context)
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'HouseDetails');
                },
                child: thirdComponent(index));
      });
}
