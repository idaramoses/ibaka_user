import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/constants.dart';

import '../screens/locationForHouseDetails.dart';

Stack customCarousal(BuildContext context) {
  return Stack(
    children: [
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Carousel(
              dotSize: 4,
              dotBgColor: Colors.transparent,
              borderRadius: false,
              showIndicator: true,
              noRadiusForIndicator: false,
              images: [
                ExactAssetImage(
                  'assets/images/carousal1.jpg',
                ),
                ExactAssetImage('assets/images/carousal2.jpg'),
                ExactAssetImage('assets/images/carousal3.jpg'),
              ],
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
                'For Sale',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hilton House',
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
                  'New York, USA   ',
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
                  '  750 (Sq Fts)',
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
      Positioned(
        top: MediaQuery.of(context).size.height * 0.32,
        left: MediaQuery.of(context).size.width - 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: CircleAvatar(
            child: Icon(
              Icons.favorite,
              color: primaryColor,
            ),
            backgroundColor: Colors.grey[100],
          ),
        ),
      )
    ],
  );
}

Container firstCompOfDetails(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.28,
    padding: EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          'N 50,000',
          style: TextStyle(
              color: primaryColor, fontSize: 28, fontWeight: FontWeight.bold),
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
                        '3 beds',
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
                    color: Theme.of(context).accentColor.withOpacity(0.4),
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
                        '5 baths',
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
                    color: Theme.of(context).accentColor.withOpacity(0.4),
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
  );
}

Container secondComponentOfDetails(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 8.0),
    height: MediaQuery.of(context).size.height * 0.25,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: kh1,
        ),
        Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,'),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.4),
        )
      ],
    ),
  );
}

Container thirdComponentOfPhotos(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.28,
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
          child: listForThirdComp(),
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
  );
}

ListView listForThirdComp() {
  List<String> urlImages = [
    'assets/images/house.jpg',
    'assets/images/house1.jpg',
    'assets/images/house2.jpg',
    'assets/images/house3.jpg',
    'assets/images/house4.jpg',
    'assets/images/house5.jpg'
  ];
  return ListView.builder(
      itemCount: urlImages.length + 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Row(
          children: [
            index == 0
                ? SizedBox(
                    width: 8,
                  )
                : Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(urlImages[index - 1]))),
                  ),
          ],
        );
      });
}

Container fourthComponent(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    height: MediaQuery.of(context).size.height * 0.25,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Details',
          style: kh1,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/check.svg',
              height: 20,
              color: primaryColor,
            ),
            Text(
              '    BosPhorus Views',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/check.svg',
              height: 20,
              color: primaryColor,
            ),
            Text(
              '    Telephone',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/check.svg',
              height: 20,
              color: primaryColor,
            ),
            Text(
              '    Family Villa',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/check.svg',
              height: 20,
              color: primaryColor,
            ),
            Text(
              '    Internet',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.4),
        )
      ],
    ),
  );
}

Container fifthComponent(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    height: MediaQuery.of(context).size.height * 0.40,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: kh1,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.red,
          ),
          child: LocationForHouseDetails(),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.4),
        )
      ],
    ),
  );
}

Container sixthComponent(BuildContext context) {
  return Container(
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
            backgroundImage: AssetImage('assets/images/person2.jpeg'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'Idara Moses',
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        )),
        Center(
            child: Text(
          'Takaful Real Estate',
          style: TextStyle(color: Colors.black, fontSize: 14),
        )),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200]),
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
            )
          ],
        )
      ],
    ),
  );
}
