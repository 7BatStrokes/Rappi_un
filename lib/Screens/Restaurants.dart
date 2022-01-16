import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';


class Restaurants extends StatefulWidget {
  static const String id = 'Restaurants';
  String myStr = 'hola';
  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    // Aca se construye la escena que se ve
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
          title: Text("Restaurantes"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
          ),
        ));
  }
}
