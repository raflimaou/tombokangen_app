// ignore_for_file: unnecessary_new, deprecated_member_use

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  const AddData({Key key}) : super(key: key);

  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  addDataSubmit() async {
    var registerUrl = Uri.parse(BASEURL.tambahProduk);
    final response = await http.post(registerUrl, body: {
      "id_category": categoryController.text,
      "name": nameController.text,
      "description": descriptionController.text,
      "image": imageController.text,
      "price": priceController.text,
      "status": statusController.text,
      "jumlah": jumlahController.text,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amber[500],
        title: const Text("TAMBAH MENU"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                      hintText: "1 atau 2",
                      labelText: "Masukkan Kategori Produk"),
                ),
                new TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Nama Produk",
                      labelText: "Masukkan Nama Produk"),
                ),
                new TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Deskripsi",
                      labelText: "Masukkan Deskripsi"),
                ),
                new TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Gambar",
                      labelText: "Masukkan Gambar"),
                ),
                new TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Harga", labelText: "Masukkan Harga"),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: const Text(
                    "Tambah Data",
                    style: TextStyle(
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
                      addDataSubmit();
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
