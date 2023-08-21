import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:ecommerce_app/widget/widget_illustration.dart';
import 'package:flutter/material.dart';

import '../main_page.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(
          height: 80,
        ),
        const WidgetIllustration(
          image: "assets/order_success.png",
          title: "Yeay, your order was successfully",
          subtitle1: "Thank you,",
          subtitle2: "Enjoy your meal",
        ),
        const SizedBox(
          height: 30,
        ),
        ButtonPrimary(
          text: "BACK TO HOME",
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPages()),
                (route) => false);
          },
        )
      ],
    )));
  }
}
