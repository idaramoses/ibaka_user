import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/constants.dart';
import 'package:onproperty/widgets/heart_container.dart';

List images = [
  'assets/images/house.jpg',
  'assets/images/carousal1.jpg',
  'assets/images/carousal2.jpg',
  'assets/images/carousal3.jpg',
  'assets/images/house.jpg',
  'assets/images/room1.jpg',
  'assets/images/apartement.jpg',
  'assets/images/carousal1.jpg',
  'assets/images/carousal2.jpg',
  'assets/images/carousal3.jpg',
  'assets/images/house.jpg',
  'assets/images/room1.jpg',
];
List<String> prices = [
  '\N567,900',
  '\N335,900',
  '\N289,700',
  '\N470,000',
  '\N224,670',
  '\N490,270',
  '\N300,600',
  '\N651,230',
  '\N980,000',
  '\N300,000',
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

Container firstComponent(BuildContext context) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
    decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(30.0)),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'SearchProperty');
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                Text(
                  'Find Rent,Sale & Buy Home',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'Filters');
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, top: 12.0, bottom: 12.0),
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                height: 20,
                width: 20,
                color: primaryColor,
              ),
            )),
      ],
    ),
  );
}

Card secondComponent(int index, BuildContext context) {
  return Card(
    margin: EdgeInsets.only(right: 8.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Container(
      height: 230,
      width: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'HouseDetails');
            },
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(images[index])),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOME FOR SALE',
                  style: kh4,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  addresses[index],
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        '3 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
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
                        ' 5 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
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
                        ' 1750 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        'sqft',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Starting Price',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          prices[index],
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 22,
                          )),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Card thirdComponent(int index) {
  return Card(
    margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      height: 130,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(
                  right: 18.0, top: 8.0, left: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(houseImg[index]))),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(
                  top: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      prices[index],
                      style: kh2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      addresses[index],
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            '3 ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'bds ',
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.grey,
                          ),
                          Text(
                            ' 5 ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'baths ',
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.grey,
                          ),
                          Text(
                            ' 1,767 ',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 5,
                            backgroundColor: Colors.green,
                          ),
                          Text(
                            ' House for Sale',
                            style: TextStyle(fontSize: 12),
                          ),
                          Spacer(),
                          HeartContainer(index)
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

ListView listForThirdComponent() {
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 6,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'HouseDetails');
            },
            child: thirdComponent(index));
      });
}
