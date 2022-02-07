import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rappi_un/Screens/Reporte.dart';

import 'Choose.dart';

firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
FireRepo _fireRepo = FireRepo();
String _image = "";

class Peticiones extends StatefulWidget{
  static const String id = 'Peticiones';
  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Peticiones>{
  List <DocumentSnapshot> allrequests = [];

  void reqs() async{
    allrequests = await _fireRepo.getPeticiones();
    setState(() {});
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
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: lesCols[4],
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          "Lista de Favores",
          style: TextStyle(
              color: lesCols[4], fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                    MaterialPageRoute(builder: (context) {
                      return Reporte();
                    }));
              },
              icon: Icon(Icons.account_box))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: <Widget>[
            Text("Favores disponibles",
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
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => print("Oaaa"),
                      child: Favour(
                        title: value["lugar"],
                        compensation: value["precio"],
                        maxDistance: value["distancia"],
                      ),
                    ),
                    SizedBox(height: 15)
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}