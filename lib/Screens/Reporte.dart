import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
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
      appBar: AppBar(
        backgroundColor: lesCols[6],
        centerTitle: true,
        title: Text("Te has esforzado al maximo!"),
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
      backgroundColor: lesCols[5],
      body: SafeArea(
          child: FutureBuilder(
              future: _fireRepo.getdatos(user.email.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  int Total = int.parse(snapshot.data["total"].toString());
                  int pedidos = int.parse(snapshot.data["pedidos"].toString());
                  List<PieChartSectionData> sectionsChart = [
                    PieChartSectionData(
                      //snapshot.data["pedido"]*100/snapshot.data["total"]
                      value: pedidos*100/Total,
                      title: "Completados: "+pedidos.toString(),
                      showTitle: true,
                      color: Colors.orange,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      value: (Total-pedidos)*100/Total,
                      title: "Fallo: "+(Total-pedidos).toString(),
                      showTitle: true,
                      color: Colors.blue,
                      radius: 100,
                    )
                  ];
                  return Scrollbar(
                    child: Column(
                      children: <Widget>[

                        Padding(padding: EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
                          child: Container(
                            color: lesCols[4],
                            child: Row(
                              children: <Widget>[
                                Positioned(child: Text("Pedidos"+"\n"+ "Completados",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: "Agrandir Text Bold",
                                    )),
                                  left: 2,
                                ),
                                Spacer(),
                                Positioned(child: Text(snapshot.data["pedidos"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: lesCols[6],
                                      fontSize: 50,
                                      fontFamily: "Agrandir Text Bold",
                                    )),)
                              ],
                            ),
                          ),),
                        Padding(padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                          child: Container(
                            color: lesCols[4],
                            child: Row(
                              children: <Widget>[
                                Positioned(child: Text("Dinero"+"\n"+ "Ganado",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: "Agrandir Text Bold",
                                    )),
                                  left: 2,
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Positioned(child: Text(snapshot.data["ganancia"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: lesCols[6],
                                      fontSize: 50,
                                      fontFamily: "Agrandir Text Bold",
                                    )),)
                              ],
                            ),
                          ),),
                        Padding(padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                          child: Container(
                            color: lesCols[4],
                            child: Row(
                              children: <Widget>[
                                Positioned(child: Text("Distancia"+"\n"+ "Recorrida",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: "Agrandir Text Bold",
                                    )),
                                  left: 2,
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Positioned(child: Text(snapshot.data["recorrido"]+" km",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: lesCols[6],
                                      fontSize: 50,
                                      fontFamily: "Agrandir Text Bold",
                                    )),)
                              ],
                            ),
                          ),),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                          child: Container(
                            height: 1,
                            width: 1,
                            child: PieChart(PieChartData(
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 0,
                                sections: sectionsChart
                            )),
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                  );
                }
              }),
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