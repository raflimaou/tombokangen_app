import 'package:ecommerce_app/pages/history_page.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/profile_page.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key key}) : super(key: key);

  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectIndex = 0;

  final _pageList = [
    const HomePages(),
    const HistoryPages(),
    const ProfilePages(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageList.elementAt(_selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded), label: "Profile"),
          ],
          currentIndex: _selectIndex,
          onTap: onTappedItem,
          selectedItemColor: yellowColor,
        ));
  }
}
