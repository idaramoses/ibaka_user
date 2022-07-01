import 'package:flutter/cupertino.dart';

class OnbordingData extends StatefulWidget {
  final imagePath;
  final title;
  final desc;

  OnbordingData({this.imagePath, this.title, this.desc});

  @override
  _OnbordingDataState createState() =>
      _OnbordingDataState(this.imagePath, this.title, this.desc);
}

class _OnbordingDataState extends State<OnbordingData> {
  final imagePath;
  final title;
  final desc;
  _OnbordingDataState(this.imagePath, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            image: AssetImage(imagePath),
          ),
          SizedBox(
            height: 40.0,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
