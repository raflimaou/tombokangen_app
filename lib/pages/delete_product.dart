// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/product_model.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteProduct extends StatefulWidget {
  const DeleteProduct({Key key}) : super(key: key);

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
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

  @override
  void initState() {
    super.initState();
    getProduct();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delete Menu"),
          backgroundColor: Colors.amber[500],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext, i) {
            final x = listProduct[i];
            return Card(
                child: ListTile(
              leading: Image.asset(x.imageProduct),
              title: Text(x.nameProduct),
              subtitle: Text("Rp. " + x.price),
              trailing: InkWell(
                  onTap: () {
                    DeleteDataSubmit(x.idProduct);
                  },
                  child: const Icon(Icons.delete)),
            ));
          },
          itemCount: listProduct.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }
}
