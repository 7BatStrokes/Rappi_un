import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

FireRepo _fireRepo = FireRepo();
User user = FirebaseAuth.instance.currentUser!;

class Reporte extends StatelessWidget{
  static const String id = "Reporte";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lesCols[5],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 0, right: 0),
          child: FutureBuilder(
              future: _fireRepo.getdatos(user.email.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  print(snapshot);
                  return Text("data");
                }
              }),
          ),
        ),
      );
  }
}

class buildStar extends StatelessWidget {
  const buildStar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 25,
      color: Colors.yellowAccent[700],
    );
  }
}