import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/AppRepository.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/MainMenu.dart';
import 'package:rappi_un/Screens/Register.dart';

final fire = FirebaseFirestore.instance;
FireRepo _firerepo = FireRepo();
AppRepo _apprepo = AppRepo();

class Welcoming extends StatefulWidget {
  static const String id = 'welcoming';
  final author = FirebaseAuth.instance;

  static String email = " ";
  static String pass = " ";

  bool noConnecting = true;

  String goog = "images/googleicon.png";

  Widget logemawidg = TheTextpls(
    obstxt: false,
    myicon: Icons.person_outline,
    bordcol: lesCols[0],
    txtcol: lesCols[0],
    onPressed: (value) {
      email = _apprepo.trimstr(value);
    },
    fon: 15,
    fillcol: lesCols[5],
    title: "Type your email, appreciated user",
  );
  Widget logpaswidg = TheTextpls(
    obstxt: true,
    bordcol: lesCols[0],
    txtcol: lesCols[0],
    onPressed: (value) {
      pass = value;
    },
    fon: 15,
    fillcol: lesCols[5],
    title: "Hope you remember your password...",
  );

  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Welcoming> {
  static String email = " ";
  static String pass = " ";

  bool noConnecting = true;

  String goog = "images/googleicon.png";

  Widget logemawidg = TheTextpls(
    obstxt: false,
    myicon: Icons.person_outline,
    bordcol: lesCols[0],
    txtcol: lesCols[6],
    onPressed: (value) {
      email = _apprepo.trimstr(value);
    },
    fon: 12,
    fillcol: lesCols[5],
    title: "Type your email, appreciated user",
  );
  Widget logpaswidg = TheTextpls(
    obstxt: true,
    myicon: Icons.vpn_key_outlined,
    bordcol: lesCols[0],
    txtcol: lesCols[6],
    onPressed: (value) {
      pass = value;
    },
    fon: 12,
    fillcol: lesCols[5],
    title: "Hope you remember your password...",
  );

  void authenticateUser(User user) {
    print("Here Second");
    _firerepo.authenticateUser(user).then((isNewUser) {
      if (user.email!.split("@")[1] == "unal.edu.co") {
        print(user.displayName);
        print("New User? " + isNewUser.toString());
        _firerepo.updatelastdateDatatoDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Menu(0);
          }));
        });
      } else {
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

  void performGoogleLogIn() async {
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('You sure you want to go back?',
            style: TextStyle(
                color: lesCols[6],
                fontFamily: "Manrope Light",
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        content: Text('Esta aplicación requiere de una cuenta de la Universidad Nacional de Colombia',
            style: TextStyle(
                color: lesCols[6],
                fontFamily: "Manrope Light",
                fontWeight: FontWeight.normal,
                fontSize: 16)),
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
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
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
