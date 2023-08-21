// import 'package:asik/screens/absensi_page.dart';
// import 'package:asik/screens/master_data/jabatan/list.dart';
// import 'package:asik/screens/master_data/karyawan/list.dart';
// ignore_for_file: camel_case_types, unused_element

import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/pages/invoice_page.dart';
import 'package:ecommerce_app/pages/view_product.dart';
import 'package:ecommerce_app/pages/view_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class adminPages extends StatefulWidget {
  const adminPages({Key key}) : super(key: key);

  @override
  _adminPagesState createState() => _adminPagesState();
}

class _adminPagesState extends State<adminPages> {
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

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Widget _menuMasterData(String Title, Deskripsi, DynamicIcon) {
      return ListTile(
        leading: Material(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.grey[200],
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(DynamicIcon),
            color: Colors.amber[500],
            iconSize: 30.0,
            onPressed: () {},
          ),
        ),
        title: Text(Title),
        contentPadding: const EdgeInsets.all(7.0),
        subtitle: Text(Deskripsi),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Nav
          //   ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[500],
        title:
            const Text('Admin', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () {
                signOut();
              },
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          color: Colors.yellowAccent,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black26,
                  ]),
            ),
            padding: const EdgeInsets.only(
              top: 50,
              left: 40,
              right: 40,
            ),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              body: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 84),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        textStyle: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewProduct()),
                        );
                      },
                      child: const Text('Lihat Daftar Menu'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        textStyle: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewUser()),
                        );
                      },
                      child: const Text('Lihat User Terdaftar'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        textStyle: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InvoicePage()),
                        );
                      },
                      child: const Text('Lihat Invoice'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
