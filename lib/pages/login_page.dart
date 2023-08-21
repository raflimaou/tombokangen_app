// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:ecommerce_app/main_page.dart';
import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:ecommerce_app/pages/register_page.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key key}) : super(key: key);

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String fullname = data['fullname'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String password = data['password'];
    String role = data['role'];
    if (value == 1) {
      savePref(idUser, fullname, email, phone, address, role, password);
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
                          builder: (context) => (role == "1")
                              ? const adminPages()
                              : const MainPages()),
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
      setState(() {});
    }
  }

  savePref(String idUser, String fullname, String email, String phone,
      String address, String role, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.idUSer, idUser);
      sharedPreferences.setString(PrefProfile.fullname, fullname);
      sharedPreferences.setString(PrefProfile.email, email);
      sharedPreferences.setString(PrefProfile.phone, phone);
      sharedPreferences.setString(PrefProfile.address, address);
      sharedPreferences.setString(PrefProfile.role, role);
      sharedPreferences.setString(PrefProfile.password, password);
    });
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
                "LOGIN",
                style: regulerTextStyle.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 8),
              Text("Login into your account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor)),
              const SizedBox(height: 20),

              //TextField
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
                  padding: const EdgeInsets.only(left: 16, bottom: 6),
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
                      text: "LOGIN",
                      onTap: () {
                        if (emailController.text.isEmpty ||
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
                          submitLogin();
                        }
                      })),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account? ",
                    style: lightTextStyle.copyWith(
                        color: greyLightColor, fontSize: 15)),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPages()),
                          (route) => false);
                    },
                    child: Text("Create account",
                        style: boldTextStyle.copyWith(
                            color: yellowColor, fontSize: 14))),
              ])
            ],
          ),
        )
      ],
    ));
  }
}
