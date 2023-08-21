// ignore_for_file: unused_import

import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/card_product.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;

  const CardCategory({Key key, this.imageCategory, this.nameCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageCategory, width: 65),
        const SizedBox(height: 1),
        Text(nameCategory, style: mediumTextStyle.copyWith(fontSize: 10)),
      ],
    );
  }
}
