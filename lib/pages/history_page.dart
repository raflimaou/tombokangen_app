import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/history_model.dart';
import 'package:ecommerce_app/network/model/pref_profile_model.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:ecommerce_app/widget/card_history.dart';
import 'package:ecommerce_app/widget/widget_illustration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPages extends StatefulWidget {
  const HistoryPages({Key key}) : super(key: key);

  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  List<HistoryOrdelModel> list = [];
  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 50,
              child: Text(
                "History Order",
                style: regulerTextStyle.copyWith(fontSize: 25),
              )),
          SizedBox(
            height: (list.isEmpty) ? 80 : 20,
          ),
          list.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const WidgetIllustration(
                      image: "assets/no_history.png",
                      subtitle1: "You dont have history order",
                      subtitle2: "lets shopping now",
                      title: "Oops, there are no history order",
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: CardHistory(
                        model: x,
                      ),
                    );
                  }),
        ]),
      ),
    );
  }
}
