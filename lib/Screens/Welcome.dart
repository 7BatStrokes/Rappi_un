import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/Choose.dart';
import 'package:rappi_un/Screens/MainMenu.dart';


final fire = FirebaseFirestore.instance;
FireRepo _firerepo = FireRepo();

class Welcoming extends StatefulWidget {
  static const String id = 'welcoming';
  final author = FirebaseAuth.instance;

  //static String email = " ";
  //static String pass = " ";
  // bool noConnecting = true;
  // String goog = "images/googleicon.png";

  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Welcoming> {

  bool noConnecting = true;

  String goog = "images/googleicon.png";

  void authenticateUser(User user) {
    print("Here Second");
    _firerepo.authenticateUser(user).then((isNewUser) {
      if (user.email!.split("@")[1] == "unal.edu.co") { //Verifica que el usuario de google sea unal
        print(user.displayName);
        print("New User? " + isNewUser.toString());
        _firerepo.addUserDatatoDb(user, user.email!).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Choose();
          }));
        });
      } else {// En caso de no ser unal muestra el error
        return (
            showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
          title: Text('Correo no válido',
              style: TextStyle(
                  color: lesCols[7],
                  fontFamily: "Manrope Light",
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          content: Text('Esta aplicación requiere de una cuenta de la Universidad Nacional de Colombia',
              style: TextStyle(
                  color: lesCols[7],
                  fontFamily: "Manrope Light",
                  fontWeight: FontWeight.normal,
                  fontSize: 15)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cerrar',
                  style: TextStyle(
                      color: lesCols[6],
                      fontFamily: "Manrope Light",
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ),
          ],
        )));
      }
    });
  }

  void performGoogleLogIn() async {// El login de google
    try {
      _firerepo.sadlySignOut();
      _firerepo.gSignIn("").then((User user) {
        if (user != null) {
          authenticateUser(user);
        } else {
          setState(() {
            noConnecting = true;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {// Aca se construye la escena que se ve
    return Scaffold(
      backgroundColor: lesCols[5],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Ingresa",
                  style: TextStyle(
                    color: lesCols[6],
                    fontSize: 60,
                    fontFamily: "Agrandir Text Bold",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Image(
                  image: AssetImage("images/rappi.png")
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                color: lesCols[6],
                thickness: 2.5,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                color: lesCols[4],
                margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                child: ListTile(
                  onTap: () async {
                    try {
                      performGoogleLogIn();
                    } catch (e) {
                      print("This is what happened: " + e.toString());
                    }
                    setState(() {
                      noConnecting = false;
                    });
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(goog),
                      ),

                      Text(
                        "Tu usuario de Google",
                        style: TextStyle(
                          color: lesCols[6],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
