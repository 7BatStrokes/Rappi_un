import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

FireRepo _fireRepo = FireRepo();

class Estado extends StatefulWidget {
  static const String id = "Estado";

  @override
  _EstadoState createState() => _EstadoState();
}

class _EstadoState extends State<Estado> {
  late DocumentSnapshot order;
  static String lab= "";

  void reqs() async {
    await _fireRepo.initiateStatus("v3UiN0AA05i52IxqCHUf").then((value) => order= value);

    setState(() {
      if (order["state"]== 1) {
        lab= "Pedido";
      } else if (order["state"]== 2) {
        lab= "Aceptado";
      } else if (order["state"]== 3) {
        lab= "Despacho";
      } else {
        lab= "Finalizado";
      };
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
          "Estado del Pedido",
          style: TextStyle(
              color: lesCols[4], fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => print("Hey"),
              icon: Icon(
                Icons.chat,
                size: 30,
                color: lesCols[4],
              )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  order["title"],
                  softWrap: true,
                  style: TextStyle(
                    color: lesCols[6],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,20,30,15),
                  child: Text(
                    order["description"],
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                      color: lesCols[7],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  color: lesCols[4],
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "\$"+order["compensation"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: lesCols[6],
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "El pedido está:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
                Slider(
                  divisions: 3,
                  min: 0,
                  max: 3,
                  value: order["state"].toDouble(),
                  activeColor: lesCols[3],
                  inactiveColor: lesCols[4],
                  thumbColor: lesCols[2],
                  onChanged: (val)=> null,
                  label: lab,

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
