import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Screens/Home.dart';
import 'package:rappi_un/Screens/RestaurantScreenList.dart';
import 'package:rappi_un/Screens/Restaurants.dart';
import 'package:rappi_un/Screens/myForm.dart';
import 'package:rappi_un/icons/my_flutter_app_icons.dart';
import 'package:rappi_un/icons/my_new_icon_icons.dart';

void main() {
  runApp(new MyChoose());
}

class MyChoose extends StatelessWidget {
  static const String id = 'MyChoose';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lesCols[5],
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(
                  top:40,
              bottom: 40,
              left: 20,
              right: 20),
              child: Column(
                children: [
                  Text(
                    "¿Qué quieres\n  pedir hoy?",
                    style: TextStyle(
                      color: lesCols[6],
                      fontSize: 50,
                      fontFamily: "Agrandir Text Bold",
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Hi");
                              Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                              MaterialPageRoute(builder: (context) {
                              return Restaurants();
                              }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(5, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 250,
                              child: Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: lesCols[3],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon( // //Imagen
                                    MyNewIcon.fast_food,
                                    size: 150,
                                    color: lesCols[6],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Comida",
                            style: TextStyle(
                              color: lesCols[6],
                              fontSize: 20,
                              fontFamily: "Agrandir Text Bold",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("SupSup");
                              Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                                  MaterialPageRoute(builder: (context) {
                                    return Myform();
                                  }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(5, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 250,
                              child: Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: lesCols[3],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    MyNewIcon.school,
                                    size: 150,
                                    color: lesCols[6],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Otros",
                            style: TextStyle(
                              color: lesCols[6],
                              fontSize: 20,
                              fontFamily: "Agrandir Text Bold",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Solo puedes tener un favor activo a la vez",
                    style: TextStyle(
                      color: lesCols[6],
                      fontSize: 15,
                      fontFamily: "Agrandir Text Bold",
                    ),
                  ),
                ],

          )),
        ),
    );
  }
}