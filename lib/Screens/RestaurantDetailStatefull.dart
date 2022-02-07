import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Screens/EstadoPedidoCompra.dart';
import 'package:rappi_un/icons/awesome5_icons.dart';
import 'package:rappi_un/icons/shopping_icons.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/ChooseFavor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'ChooseFavor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
FireRepo _firerepo = FireRepo();
User user = FirebaseAuth.instance.currentUser!;
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

class RestaurantDetailStateful extends StatefulWidget {
  static const String id = 'RestaurantDetailStateful';
  final DocumentSnapshot snapshot;

  const RestaurantDetailStateful({Key? key, required this.snapshot})
      : super(key: key);

  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<RestaurantDetailStateful> {
  List<int> counter = List.filled(100, 0, growable: true);
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
          minimum: EdgeInsets.only(right: 5, left: 15, bottom: 0, top: 10),
          child: Column(children: [
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FadeInImage.assetNetwork(
                        placeholder: 'images/loading.gif',
                        image: widget.snapshot.get("imagen"),
                      ).image,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(widget.snapshot.get("nombre"),
                        style: TextStyle(
                          color: lesCols[6],
                          fontSize: 27,
                          fontFamily: "Agrandir Text Bold",
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.snapshot.get("direccion"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "MyFlutterApp",
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        if (widget.snapshot.get("estrellas") > 0) buildStar(),
                        SizedBox(
                          width: 3,
                        ),
                        if (widget.snapshot.get("estrellas") > 1) buildStar(),
                        SizedBox(
                          width: 3,
                        ),
                        if (widget.snapshot.get("estrellas") > 2) buildStar(),
                        SizedBox(
                          width: 3,
                        ),
                        if (widget.snapshot.get("estrellas") > 3) buildStar(),
                        SizedBox(
                          width: 3,
                        ),
                        if (widget.snapshot.get("estrellas") > 4) buildStar()
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 65,
              child: Text(widget.snapshot.get("descripcionLarga"),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: "MyFlutterApp",
                  )),
            ),
            Divider(
              height: 15,
              thickness: 2,
              color: Colors.black,
            ),
            Container(
                width: 400,
                child: Text("Platillos",
                    style: TextStyle(
                      color: lesCols[6],
                      fontSize: 24,
                      fontFamily: "Agrandir Text Bold",
                    ))),
            Expanded(
                child: Scrollbar(
                    thickness: 5,
                    interactive: true,
                    isAlwaysShown: true,
                    child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 6),
                          itemCount: widget.snapshot.get("platillos").length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FadeInImage.assetNetwork(
                                        placeholder: 'images/loading.gif',
                                        image: widget.snapshot
                                            .get("platillos")[index]["imagen"],
                                      ).image,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 185,
                                        height: 20,
                                        child: Text(
                                            widget.snapshot
                                                    .get("platillos")[index]
                                                ["nombre"],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Agrandir Text Bold",
                                            )),
                                      ),
                                      Container(
                                        width: 185,
                                        height: 49,
                                        child: Text(
                                            widget.snapshot
                                                    .get("platillos")[index]
                                                ["descripcion"],
                                            softWrap: false,
                                            maxLines: 3,
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: "MyFlutterApp",
                                            )),
                                      ),
                                      Container(
                                          width: 195,
                                          height: 30,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 95,
                                                  child: Text(
                                                      "precio: " +
                                                          widget.snapshot.get(
                                                                  "platillos")[
                                                              index]["precio"],
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontFamily:
                                                            "Agrandir Text Bold",
                                                      ))),
                                              IconButton(
                                                iconSize: 15,
                                                icon: const Icon(
                                                    Awesome5.minus_circle),
                                                onPressed: () {if (counter[index]>0)      setState((){

                                                counter[index] -= 1;
                                                });
                                                }
                                                ,
                                              ),
                                              Container(
                                                width: 4,
                                                child: Text(
                                                    counter[index].toString()),
                                              ),
                                              IconButton(
                                                iconSize: 15,
                                                icon: const Icon(
                                                    Awesome5.plus_circle),
                                                onPressed: () {
                                                  setState((){counter[index] += 1;});
                                                },
                                              ),
                                            ],
                                          ))
                                    ]),
                              ],
                            ));
                          },
                        )))),
            Container(
                width: 350,
                height: 40,
                alignment: Alignment.center,
                child: IconButton(
                  iconSize: 27,
                  icon: const Icon(Shopping.basket),
                  onPressed: () {


                    if(finalPrice()==0){
                      showDialog(context: context, builder: (_) => new AlertDialog(
                        content: Text("Por favor agrega una o mas comidas para la compra"),

                      ));
                    }
                    else{

                      showDialog(

                        context: context,
                        builder: (_) => new AlertDialog(
                          insetPadding: EdgeInsets.all(15),
                          title: Text("¿Estas seguro de subir la petición?",textAlign: TextAlign.center,),
                          content: Text("Restaurante: "+widget.snapshot.get("nombre")+"\nDireccion: " +widget.snapshot.get("direccion")+
                              "\nPlatillos: \n" +strPlatillos()+ "Precio total: "+ finalPrice().toString()+" mas comision por favor" ,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: "MyFlutterApp",
                          ),
                          textAlign: TextAlign.start,
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () async{
                                _firestore.collection("peticiones").add({
                                  'objeto': strPlatillos(),
                                  'lugar': widget.snapshot.get("nombre"),
                                  'distancia': widget.snapshot.get("direccion"),
                                  'precio': finalPrice().toString(),
                                  'imagen': widget.snapshot.get("imagen"),
                                  'solicitante':  user.email,
                                  'repartidor': '',
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EstadoPedidoCompra(precio: finalPrice(), objeto: strPlatillosNombre(),)));
                              },
                              child: new Text('Confirmar'),
                              textColor: Colors.blue,
                            ),
                            new FlatButton(
                              onPressed: () {Navigator.of(context).pop();},
                              child: new Text('Cancelar'),
                              textColor: Colors.red,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ))
          ])),
    );
  }
int finalPrice(){
    int sum=0;
    for (int i=0; i<counter.length ; i++){
      if (counter[i]!=0){
        sum+=counter[i]* int.parse(widget.snapshot.get("platillos")[i]["precio"]);
      }
    }
    return sum;
}
String strPlatillos(){
    String rt="";
  for (int i=0; i<counter.length ; i++){
    if (counter[i]!=0){
      rt+="Nombre: "+ (widget.snapshot.get("platillos")[i]["nombre"])+" Cantidad: "
          +counter[i].toString()+" Precio: "+(counter[i]* int.parse(widget.snapshot.get("platillos")[i]["precio"])).toString()+ "\n";
    }
  }
  return rt;
}
  String strPlatillosNombre(){
    String rt="";
    for (int i=0; i<counter.length ; i++){
      if (counter[i]!=0){
        rt+=(widget.snapshot.get("platillos")[i]["nombre"])+"\n";
      }
    }
    return rt;
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
      size: 30,
      color: Colors.yellowAccent[700],
    );
  }
}

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}
