// ignore_for_file: use_key_in_widget_constructors, avoid_print, unnecessary_string_interpolations

import 'dart:convert';

import 'package:ecommerce_app/main_page.dart';
import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/cart_model.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/pages/success_checkout.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:ecommerce_app/widget/widget_illustration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPages extends StatefulWidget {
  final VoidCallback method;
  const CartPages(this.method);
  @override
  _CartPagesState createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  final price = NumberFormat("#,##0", "EN_US");
  String userID, fullname, address, phone;
  int delivery = 0;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
      fullname = sharedPreferences.getString(PrefProfile.fullname);
      address = sharedPreferences.getString(PrefProfile.address);
      phone = sharedPreferences.getString(PrefProfile.phone);
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listCart = [];
  getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  updateQuantity(String tipe, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http
        .post(urlUpdateQuantity, body: {"cartID": model, "tipe": tipe});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
        widget.method();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final response = await http.post(urlCheckout, body: {
      "idUser": userID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SuccessCheckout()),
          (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(24),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color(0xfffcfcfc),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Items",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "IDR " + price.format(int.parse(sumPrice)),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        delivery == 0 ? "FREE" : delivery,
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "IDR " + price.format(totalPayment),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        checkout();
                      },
                      text: "CHECKOUT NOW",
                    ),
                  )
                ],
              ),
            ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.only(bottom: 220),
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 32,
                    color: yellowColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "My Cart",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                )
              ])),
          listCart.isEmpty || listCart.length == null
              ? Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 30),
                  child: WidgetIllustration(
                    image: "assets/empty_cart_illustration-removebg.png",
                    title: "Oops, there are no products in your cart",
                    subtitle1: "Your cart is still empty, browse the",
                    subtitle2: "attractive products from TOMBO KANGEN",
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "SHOPPING NOW",
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPages()),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(24),
                  height: 166,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Destination",
                        style: regulerTextStyle.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$fullname",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Address",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$address",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$phone",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          ListView.builder(
              itemCount: listCart.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final x = listCart[i];
                return Container(
                  padding: const EdgeInsets.all(24),
                  color: whiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            x.image,
                            width: 115,
                            height: 100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.name,
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: yellowColor,
                                        ),
                                        onPressed: () {
                                          updateQuantity("tambah", x.idCart);
                                        }),
                                    Text(x.quantity),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Color(0xfff0997a),
                                        ),
                                        onPressed: () {
                                          updateQuantity("kurang", x.idCart);
                                        }),
                                  ],
                                ),
                                Text(
                                  "IDR " + price.format(int.parse(x.price)),
                                  style: boldTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                );
              })
        ],
      )),
    );
  }
}
