// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, unnecessary_const

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/product_model.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final ProductModel model;
  const EditData(this.model);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  EditDataSubmit() async {
    var registerUrl = Uri.parse(BASEURL.editProduk);
    final response = await http.post(registerUrl, body: {
      "id_product": widget.model.idProduct,
      "id_category": categoryController.text,
      "name": nameController.text,
      "description": descriptionController.text,
      "image": imageController.text,
      "price": priceController.text,
    });
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

  setup() {
    categoryController = TextEditingController(text: widget.model.idCategory);
    nameController = TextEditingController(text: widget.model.nameProduct);
    descriptionController =
        TextEditingController(text: widget.model.description);
    imageController = TextEditingController(text: widget.model.imageProduct);
    priceController = TextEditingController(text: widget.model.price);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[500],
        title: const Text("Edit Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                      hintText: "1 atau 2",
                      labelText: "Masukkan Kategori Produk"),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Nama Produk",
                      labelText: "Masukkan Nama Produk"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Deskripsi",
                      labelText: "Masukkan Deskripsi"),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Gambar",
                      labelText: "Masukkan Gambar"),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Harga", labelText: "Masukkan Harga"),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: const Text(
                    "Edit Data",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.amber[500],
                  onPressed: () {
                    if (categoryController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        imageController.text.isEmpty ||
                        priceController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Warning!"),
                                content:
                                    const Text("Please, enter the fields."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"))
                                ],
                              ));
                    } else {
                      EditDataSubmit();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
