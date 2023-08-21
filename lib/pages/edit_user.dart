// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/user_model.dart';
import 'package:ecommerce_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  final UserModel model;
  const EditUser(this.model);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  EditUserSubmit() async {
    print(widget.model.idUser);
    var registerUrl = Uri.parse(BASEURL.editUser);
    final response = await http.post(registerUrl, body: {
      "id_user": widget.model.idUser,
      "fullname": fullnameController.text,
      "address": addressController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text,
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
                          builder: (context) => const ProfilePages()),
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
    fullnameController = TextEditingController(text: widget.model.fullnameUser);
    addressController = TextEditingController(text: widget.model.addressUser);
    phoneController = TextEditingController(text: widget.model.phoneUser);
    emailController = TextEditingController(text: widget.model.emailUser);
    passwordController = TextEditingController(text: widget.model.passwordUser);
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
                  controller: fullnameController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Nama Lengkap",
                      labelText: "Masukkan Nama Lengkap"),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Alamat",
                      labelText: "Masukkan Alamat"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Nomor Telephone",
                      labelText: "Masukkan Nomor Telephone"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Masukkan Email",
                    labelText: "Masukkan Email",
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan Password",
                      labelText: "Masukkan Password"),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: const Text(
                    "Edit Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.amber[500],
                  onPressed: () {
                    if (fullnameController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        passwordController.text.isEmpty) {
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
                      EditUserSubmit();
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
