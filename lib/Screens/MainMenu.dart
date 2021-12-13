import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Screens/Home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Menu extends StatefulWidget {
  static const id = "MainMenu";
  Menu(this.number);
  final int number;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PageController pagecontrol = PageController();
  int numbpage = 0;

  void onPage(int b) {
    setState(() {
      numbpage = b;
    });
  }

  void onTapped(int a) {
    pagecontrol.jumpToPage(a);
  }

  @override
  void initState() {
    super.initState();
    numbpage = widget.number;
    pagecontrol = PageController(initialPage: numbpage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[700],
      body: PageView(
        children: <Widget>[MyHome(), MyHome(), MyHome()],
        controller: pagecontrol,
        onPageChanged: onPage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.question_answer,
              color: numbpage == 0 ? lesCols[6] : Colors.yellowAccent[700],
              size: 30),
          Icon(Icons.help,
              color: numbpage == 1 ? lesCols[6] : Colors.yellowAccent[700],
              size: 30),
          Icon(Icons.person,
              color: numbpage == 2 ? lesCols[6] : Colors.yellowAccent[700],
              size: 30),
        ],
        color: lesCols[1]!,
        backgroundColor: lesCols[5]!,
        buttonBackgroundColor: lesCols[5],
        onTap: onTapped,
        index: numbpage,
        animationDuration: Duration(milliseconds: 200),
        height: 55,
      ),
    );
  }
}
