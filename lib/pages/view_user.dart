// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewUser extends StatefulWidget {
  const ViewUser({Key key}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  List<UserModel> listUser = [];
  getUser() async {
    listUser.clear();
    var urlUser = Uri.parse(BASEURL.getUser);
    final response = await http.get(urlUser);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map user in data) {
          listUser.add(UserModel.fromJson(user));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar User"),
          backgroundColor: Colors.amber[500],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext, i) {
            final x = listUser[i];
            return Card(
              child: ListTile(
                title: Text(x.fullnameUser),
                subtitle: Text(x.emailUser),
                trailing: const Icon(Icons.people),
              ),
            );
          },
          itemCount: listUser.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }
}
