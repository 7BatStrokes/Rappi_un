import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FirebaseRepository.dart';

FireRepo _fireRepo = FireRepo();

class AppMethods {
  String givemedatepls() {
    String a = "";

    a = DateTime.now().month.toString() +
        "/" +
        DateTime.now().day.toString() +
        "/" +
        DateTime.now().year.toString();

    return a;
  }

  String givemeabetterdatenow(List<String> gg) {
    String bb = "";

    if (gg[0] == "1") {
      bb += "January ";
    } else if (gg[0] == "2") {
      bb += "February ";
    } else if (gg[0] == "3") {
      bb += "March ";
    } else if (gg[0] == "4") {
      bb += "April ";
    } else if (gg[0] == "5") {
      bb += "May ";
    } else if (gg[0] == "6") {
      bb += "June ";
    } else if (gg[0] == "7") {
      bb += "July ";
    } else if (gg[0] == "8") {
      bb += "August ";
    } else if (gg[0] == "9") {
      bb += "September ";
    } else if (gg[0] == "10") {
      bb += "October ";
    } else if (gg[0] == "11") {
      bb += "November ";
    } else {
      bb += "December ";
    }

    try {
      if (gg[1].substring(0, 2) == "11" ||
          gg[1].substring(0, 2) == "12" ||
          gg[1].substring(0, 2) == "13") {
        bb += gg[1] + "th ";
      } else if (gg[1].endsWith("1")) {
        bb += gg[1] + "st ";
      } else if (gg[1].endsWith("2")) {
        bb += gg[1] + "nd ";
      } else if (gg[1].endsWith("3")) {
        bb += gg[1] + "rd ";
      } else {
        bb += gg[1] + "th ";
      }
    } catch (e) {
      print(e);
    }

    bb += "of " + gg[2];

    return bb;
  }

  bool wording(String a, String b) {
    a = a
        .replaceAll(RegExp(","), "")
        .substring(1, a.length - a.split(" ").length)
        .toLowerCase();

    return !a.split(" ").contains(b.toLowerCase());
  }

  Future<bool> wordingNew(String a, String b) async {
    a = a
        .replaceAll(RegExp(","), "")
        .substring(1, a.length - a.split(" ").length)
        .toLowerCase();
    List x = a.split(" ");
    String currentname = await _fireRepo.getMyUsername();
    x.remove(currentname);

    return !x.contains(b.toLowerCase());
  }

  String trimstr(String a) {
    print("1: "+a);
    a = a.replaceAll(RegExp(" "), "");
    print("2: "+a);
    return a;
  }

  List<Widget> profilepics() {
    List<Widget> a = [];
    List achieve = [
      "images/0.png",
      "images/1.png",
      "images/2.png",
      "images/3.png",
      "images/4.png",
      "images/5.png",
      "images/6.png",
      "images/7.png",
      "images/8.png",
      "images/9.png",
      "images/10.png",
      "images/11.png",
      "images/12.png",
      "images/13.png",
      "images/14.png",
      "images/15.png",
      "images/16.png",
      "images/17.png",
      "images/18.png",
      "images/19.png",
      "images/20.png",
    ];
    for (var i in achieve) {
      a.add(CircleAvatar(
        backgroundColor: Colors.grey[400],
        radius: 55,
        child: CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage(i),
            backgroundColor: Colors.transparent),
      ));
    }

    return a;
  }
}
