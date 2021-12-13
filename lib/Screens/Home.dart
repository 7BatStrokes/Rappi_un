import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/AppRepository.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

FireRepo _fireRepo = FireRepo();
AppRepo _appRepo = AppRepo();

class MyHome extends StatefulWidget {
  static const String id = "myhome";

  @override
  _MyHomeState createState() => _MyHomeState();
}

Icon iconic = Icon(Icons.group_add, color: lesCols[6]);
String unreliable = "Find new Friends";
bool addfriend = true;
bool search = false;

class _MyHomeState extends State<MyHome> {
  Widget animSwitch = SizedBox(height: 0.5);
  List tempSearch = [];
  List<DocumentSnapshot> query = [];
  List allrequests = [];

  void reqs() async {
    List<DocumentSnapshot> requests = await _fireRepo.initiaterequests();
    List items = [];
    requests.forEach((value) {
      items.add(value);
    });
    setState(() {
      allrequests = items;
    });
  }

  void initiateSearch(bool addfriend, String search) async {
    User user = await _fireRepo.getCurrentUser();
    if (_appRepo.trimstr(search).length == 0) {
      setState(() {
        query = [];
        tempSearch = [];
      });
    }
    if (search.length == 1) {
      query = await _fireRepo.searchforFriend(addfriend, search);
    } else {
      tempSearch = [];
      for (var i in query) {
        if (i["uid"] == user.uid) {
        } else if (i["username"]
            .toLowerCase()
            .startsWith(search.toLowerCase())) {
          setState(() {
            tempSearch.add(i);
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    reqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
        icon: Icon(
          Icons.mood_bad,
          size: 35,
          color: Colors.black,
        ),
        onPressed: () {
          print("Sup");
        },
      )),
    );
  }
}
