import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lesCols[5],
      appBar: AppBar(
        backgroundColor: lesCols[6],
        centerTitle: true,
        title: Text("Peticiones"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                MaterialPageRoute(builder: (context) {
                    return Choose();
                }));
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 30, left: 15,right: 3),
          child: FutureBuilder(
            future: _fireRepo.getPeticiones(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              } else {
                return Scrollbar(
                    isAlwaysShown: true,
                    thickness: 5,
                    interactive: true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 17),
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 20),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Aca se construye lo que sea que quiero el numero de item cuonts veces

                            return Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFFAAE690),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: BodyList(snapshot,index)
                            );
                          }
                      ),
                    ));
              }
          },
          ),
        ),
      ),
    );
  }
}

class BodyList extends StatelessWidget{
  AsyncSnapshot snapshot;
  int index;
  BodyList(this.snapshot,this.index);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Container(
          height: 20,
          child: Text(snapshot.data[index]["objeto"],
              style: TextStyle(
              color: lesCols[6],
              fontSize: 20,
              fontFamily: "Agrandir Text Bold",
              )
          ),
        ),
      if(snapshot.data[index]["imagen"]!="")
        Container(
          height: 20,
          alignment: Alignment.center,
          child: Text(texto(snapshot.data[index]["imagen"]).toString()),
          //child: Text(snapshot.data[index]["imagen"]),
        )
      ],
    );
  }
}

Future<String> texto(String name) async{
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref("imagenes").child(name)
      .getDownloadURL();

  print(downloadURL);
  return downloadURL;
}