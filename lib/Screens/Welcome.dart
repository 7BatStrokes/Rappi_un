import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/AppRepository.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/MainMenu.dart';
import 'package:rappi_un/Screens/Register.dart';
import 'package:flutter/gestures.dart';

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
      if (!isNewUser) {
        print(user.displayName);
        print("New User? " + isNewUser.toString());
        _firerepo.updatelastdateDatatoDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Menu(0);
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Register();
        }));
      }
    });
  }

  void performGoogleLogIn() async {
    try {
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

  void performLogIn() async {
    setState(() {
      noConnecting = false;
    });
    try {
      print(email + pass);
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (user != null) {
        _firerepo.updatelastdateDatatoDb(user.user!);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Menu(0);
        }));
      } else {
        print("Finally got here....");
        setState(() {
          noConnecting = true;
        });
      }
    } catch (E) {
      try {
        noConnecting = true;
        QuerySnapshot result = await fire
            .collection("users")
            .where("email", isEqualTo: email)
            .get();
        if (result.docs.length == 0) {
          setState(() {
            logemawidg = TheTextpls(
              obstxt: false,
              bordcol: lesCols[0],
              txtcol: lesCols[0],
              txt: "Yes, we checked and we do not recognise that last email",
              onPressed: (value) {
                email = _apprepo.trimstr(value);
              },
              title: "Isn't it your first time here? Try Signing Up",
            );
          });
        } else {
          setState(() {
            logemawidg = TheTextpls(
              obstxt: false,
              bordcol: lesCols[0],
              txtcol: lesCols[0],
              onPressed: (value) {
                print("HiHi");
                email = _apprepo.trimstr(value);
                print("BaiBai");
              },
              fon: 15,
              fillcol: lesCols[5],
              title: "Type your email, appreciated user",
            );
            logpaswidg = TheTextpls(
              fillcol: lesCols[5],
              txt: "Something is off...",
              title: "Try again your password",
              obstxt: true,
              onPressed: (value) {
                pass = value;
              },
            );
          });
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lesCols[5],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 250,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Rappi",
                      style: TextStyle(
                        color: lesCols[6],
                        fontSize: 60,
                        fontFamily: "MADE Evolve Sans Regular EVO",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  logemawidg,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      logpaswidg,
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Manrope Light",
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  color: lesCols[6],
                                  fontFamily: "Manrope Light",
                                  fontSize: 40),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: ShapeDecoration(
                                shape: const StadiumBorder(),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [lesCols[3]!, lesCols[0]!],
                                ),
                              ),
                              child: MaterialButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: StadiumBorder(),
                                child: Icon(
                                  Icons.east,
                                  color: lesCols[5],
                                  size: 35,
                                ),
                                onPressed: () {
                                  performLogIn();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Don't have an account?"),
                        TextSpan(
                          text: " Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Navigator.pushNamed(context, Register.id),
                          style: TextStyle(
                              color: lesCols[0],
                              fontFamily: "Manrope Light",
                              fontSize: 17),
                        ),
                      ],
                      style: TextStyle(
                          fontFamily: "Manrope Thin",
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      try {
                        performGoogleLogIn();
                      } catch (e) {
                        print("This is what happened: " + e.toString());
                      }
                      setState(() {
                        noConnecting = false;
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(goog),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
