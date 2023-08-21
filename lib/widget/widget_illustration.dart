import 'package:ecommerce_app/theme.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class WidgetIllustration extends StatelessWidget {
  final Widget child;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;

  const WidgetIllustration(
      {Key key,
      this.child,
      this.image,
      this.title,
      this.subtitle1,
      this.subtitle2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Image.asset(image, width: 250),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: regulerTextStyle.copyWith(fontSize: 14, color: yellowColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(children: [
          Text(
            subtitle1,
            style:
                regulerTextStyle.copyWith(fontSize: 20, color: greyBoldColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle2,
            style:
                regulerTextStyle.copyWith(fontSize: 20, color: greyLightColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          child ?? const SizedBox(),
        ])
      ]),
    );
  }
}
