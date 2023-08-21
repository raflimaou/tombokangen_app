// ignore_for_file: unused_import, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/network/model/user_model.dart';
import 'package:ecommerce_app/pages/edit_user.dart';
import 'package:ecommerce_app/pages/login_page.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePages extends StatefulWidget {
  const ProfilePages({Key key}) : super(key: key);

  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  String idUSer, fullname, phone, email, address;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idUSer = sharedPreferences.getString(PrefProfile.idUSer);
      fullname = sharedPreferences.getString(PrefProfile.fullname);
      phone = sharedPreferences.getString(PrefProfile.phone);
      email = sharedPreferences.getString(PrefProfile.email);
      address = sharedPreferences.getString(PrefProfile.address);
    });
    getCart();
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUSer);
    sharedPreferences.remove(PrefProfile.fullname);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPages()),
        (route) => false);
  }

  List<UserModel> listUser = [];
  getCart() async {
    listUser.clear();
    var urlGetUser = Uri.parse(BASEURL.getUserById + idUSer);
    final response = await http.get(urlGetUser);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listUser.add(UserModel.fromJson(item));
        }
      });
    }
    print(listUser[0].fullnameUser);
  }

  void nav_edit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUser(listUser[0])),
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Profile",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                InkWell(
                  onTap: () {
                    signOut();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: yellowColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (listUser.isNotEmpty)
                      ? listUser[0].fullnameUser
                      : 'default value',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Joined",
                  style: lightTextStyle,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone",
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  (listUser.isNotEmpty)
                      ? listUser[0].phoneUser
                      : 'default value',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  (listUser.isNotEmpty)
                      ? listUser[0].emailUser
                      : 'default value',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  (listUser.isNotEmpty)
                      ? listUser[0].addressUser
                      : 'default value',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: yellowColor,
                    onPrimary: Colors.white,
                    textStyle: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    (listUser.isNotEmpty) ? nav_edit() : '';
                  },
                  child: const Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
