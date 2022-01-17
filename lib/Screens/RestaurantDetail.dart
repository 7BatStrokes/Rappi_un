import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';

class RestaurantDetail extends StatelessWidget {
  static const String id = 'RestaurantDetail';
  DocumentSnapshot snapshot;
  RestaurantDetail(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
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
            minimum: EdgeInsets.all(15),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(snapshot.get("imagen")))),
                  ),
                Column(children: [
                  Text(snapshot.get("nombre")),
                  Text(snapshot.get("direccion")),
                ],)
                ],
              ),
              SizedBox(height: 5,),
              Text(snapshot.get("descripcionLarga"))
            ])));
  }
}
