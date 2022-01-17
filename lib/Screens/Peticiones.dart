import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';

import 'Choose.dart';

class Peticiones extends StatefulWidget{
  static const String id = 'Peticiones';
  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Peticiones>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lesCols[5],
      appBar: AppBar(
        backgroundColor: lesCols[6],
        centerTitle: true,
        title: Text("Peticiones"),
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
                onPressed: (){
                  Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                  MaterialPageRoute(builder: (context) {
                    return Choose();
                  }));
                },
                icon: Icon(Icons.arrow_back),
            );
          },
        ),
      ),
    );
  }

}