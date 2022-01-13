import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Screens/Welcome.dart';
import 'package:rappi_un/icons/my_flutter_app_icons.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

void main() {
  runApp(new Choose());
}
FireRepo _fireRepo = FireRepo();

class Choose extends StatelessWidget {
  static const String id = 'Choose';
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
                    "¿Qué quieres\n  hacer hoy?",
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
                                    MyFlutterApp.handv2,
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
                            "Pedir un favor",
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
                              try {
                                _fireRepo.sadlySignOut();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Welcoming();
                                    }));
                              } catch (E) {
                                print(E);
                              }
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
                                    Icons.directions_bike_outlined,
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
                            "Ayudar a alguien",
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
                    "Recuerda que puedes cambiar de rol después",
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