// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/pages/login_page.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPages extends StatefulWidget {
  const RegisterPages({Key key}) : super(key: key);

  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
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

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
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
                          builder: (context) => const LoginPages()),
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
        body: ListView(
      padding: const EdgeInsets.only(
        top: 80.0,
        left: 40,
        right: 40,
      ),
      children: [
        Center(
          child: Image.asset(
            'assets/logo.png',
            width: 80,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          child: Column(
            children: [
              Text(
                "REGISTER",
                style: regulerTextStyle.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 8),
              Text("Register new your account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor)),
              const SizedBox(height: 20),

              //TextField
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffFFC700),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)))),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffFFC700),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Address',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)))),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffFFC700),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)))),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffFFC700),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)))),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffFFC700),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: passwordController,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: _secureText
                                  ? Icon(Icons.visibility_off,
                                      size: 20, color: yellowColor)
                                  : Icon(Icons.visibility,
                                      size: 20, color: yellowColor)),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)))),
              const SizedBox(height: 30),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                      text: "REGISTER",
                      onTap: () {
                        if (fullnameController.text.isEmpty ||
                            addressController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            emailController.text.isEmpty ||
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
                          registerSubmit();
                        }
                      })),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account? ",
                    style: lightTextStyle.copyWith(
                        color: greyLightColor, fontSize: 15)),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPages()),
                          (route) => false);
                    },
                    child: Text("Login now",
                        style: boldTextStyle.copyWith(
                            color: yellowColor, fontSize: 15))),
              ]),
              const SizedBox(height: 30),
            ],
          ),
        )
      ],
    ));
  }
}
