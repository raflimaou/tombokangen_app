// ignore_for_file: unused_import

import 'package:ecommerce_app/main_page.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/pages/admin_pages.dart';
import 'package:ecommerce_app/pages/register_page.dart';
import 'package:ecommerce_app/widget/button_primary.dart';
import 'package:ecommerce_app/widget/widget_illustration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID, role;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
      role = sharedPreferences.getString(PrefProfile.role);
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (role == "1") ? const adminPages() : const MainPages(),
        ));
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
      body: WidgetIllustration(
        image: "assets/startedpage.png",
        title: "Selamat Datang di Tombo Kangen",
        subtitle1:
            "Rumah makan yang memberikan cita rasa autentik dan sangat berkelas",
        subtitle2: "",
        child: ButtonPrimary(
          text: "GET STARTED",
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const RegisterPages()));
          },
        ),
      ),
    );
  }
}
