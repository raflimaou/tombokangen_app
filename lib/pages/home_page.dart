// ignore_for_file: unused_import, avoid_print

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/network/model/product_model.dart';
import 'package:ecommerce_app/pages/cart_pages.dart';
import 'package:ecommerce_app/pages/detail_product.dart';
import 'package:ecommerce_app/pages/history_page.dart';
import 'package:ecommerce_app/pages/search_product.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/card_category.dart';
import 'package:ecommerce_app/widget/card_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int index;
  bool filter = false;

  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
  }

  var jumlahCart = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(BASEURL.getTotalCart + userID);
    final response = await http.get(urlGetTotalCart);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String jumlah = data['Jumlah'];
      setState(() {
        jumlahCart = jumlah;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/ayam_card.png",
                    width: 100,
                  ),
                  Text(
                    "Welcome to \nTombo Kangen Store!",
                    style: regulerTextStyle.copyWith(fontSize: 15),
                  )
                ],
              ),
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPages(totalCart)));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: yellowColor,
                      )),
                  jumlahCart == "0"
                      ? const SizedBox()
                      : Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(jumlahCart,
                                    style: regulerTextStyle.copyWith(
                                        color: whiteColor, fontSize: 10))),
                          ),
                        )
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchProduct()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffee92)),
                child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xffb1d8b2),
                        ),
                        hintText: "Search food...",
                        hintStyle: regulerTextStyle.copyWith(
                            color: const Color(0xffb1d8b2))))),
          ),
          const SizedBox(height: 32),
          Text("Category", style: regulerTextStyle.copyWith(fontSize: 16)),
          const SizedBox(height: 14),
          GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: listCategory.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, i) {
                final x = listCategory[i];
                return InkWell(
                  onTap: () {
                    setState(() {
                      index = i;
                      filter = true;
                      print("$index, $filter");
                    });
                  },
                  child: CardCategory(
                      imageCategory: x.image, nameCategory: x.category),
                );
              }),
          const SizedBox(height: 14),
          Text("Menu", style: regulerTextStyle.copyWith(fontSize: 16)),
          filter
              ? GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: listCategory[index].product.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, i) {
                    final y = listCategory[index].product[i];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                            nameProduct: y.nameProduct,
                            imageProduct: y.imageProduct,
                            price: y.price));
                  })
              : GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: listProduct.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, i) {
                    final y = listProduct[i];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                            nameProduct: y.nameProduct,
                            imageProduct: y.imageProduct,
                            price: y.price));
                  }),
        ],
      ),
    ));
  }
}
