// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/product_model.dart';
import 'package:ecommerce_app/pages/add_data.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:ecommerce_app/pages/edit_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
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
      // getProduct();
    }
  }

  DeleteDataSubmit(String idProduct) async {
    print(idProduct);
    var Url = Uri.parse(BASEURL.deleteProduk);
    final response = await http.post(Url, body: {"id_product": idProduct});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const adminPages()),
                      (route) => false);
                },
                child: const Text("Ok"))
          ],
        ),
      );
      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Menu"),
        backgroundColor: Colors.amber[500],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddData()),
                  );
                },
                icon: const Icon(Icons.add)),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext, i) {
          final x = listProduct[i];
          return Card(
            child: ListTile(
              leading: Image.asset(x.imageProduct),
              title: Text(x.nameProduct),
              subtitle: Text("Rp. " + x.price),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditData(x)));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        DeleteDataSubmit(x.idProduct);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
            ),
          );
        },
        itemCount: listProduct.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
