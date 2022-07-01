import 'package:flutter/material.dart';
import 'package:onproperty/provider/theme_provider.dart';
import 'package:onproperty/utils/colorscheme.dart';
import 'package:onproperty/utils/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  CustomButton({this.onTap, @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.CHAT_ICON_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: Provider.of<SixThemeProvider>(context).darkTheme
                ? null
                : LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    ColorResources.COLOR_BLUE,
                    ColorResources.COLOR_BLUE,
                  ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}
