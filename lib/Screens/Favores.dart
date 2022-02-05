import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

FireRepo _fireRepo = FireRepo();

class Favores extends StatefulWidget {
  static const String id = "Favores";

  @override
  _FavoresState createState() => _FavoresState();
}

class _FavoresState extends State<Favores> {
  List<DocumentSnapshot> allrequests = [];

  void reqs() async {
    List<DocumentSnapshot> requests = await _fireRepo.initiaterequests();
    requests.forEach((value) {
      allrequests.add(value);
    });
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    reqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lesCols[5],
      floatingActionButton: FloatingActionButton(
        backgroundColor: lesCols[6],
        child: Icon(
          Icons.refresh,
          color: lesCols[4],
        ),
        onPressed: () => setState(() {
        }),
      ),
      appBar: AppBar(
        backgroundColor: lesCols[6],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: lesCols[4],
          iconSize: 30,
          onPressed: () {
            print("BaiBai");
          },
        ),
        title: Text(
          "Lista de Favores",
          style: TextStyle(
              color: lesCols[4], fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: <Widget>[
            Text(
              "Favores disponibles",
              style: TextStyle(
                color: lesCols[7],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            ListView(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15, right: 15),
              children: allrequests.map((value) {
                return value["show"]
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () => print("Oaaa"),
                            child: Favour(
                              title: value["title"],
                              compensation: value["compensation"],
                              maxDistance: value["maxD"],
                              minDistance: value["minD"],
                              show: value["show"],
                            ),
                          ),
                          SizedBox(height: 15)
                        ],
                      )
                    : SizedBox();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
