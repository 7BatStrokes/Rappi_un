import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Screens/Home.dart';
import 'package:rappi_un/Screens/Welcome.dart';
import 'package:rappi_un/Screens/Register.dart';
import 'package:rappi_un/Screens/Check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Rappi());
}

class Rappi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Check.id,
      routes: {
        Check.id: (context) => Check(),
        Welcoming.id: (context) => Welcoming(),
        Register.id: (context) => Register(),
        MyHome.id: (context) => MyHome(),
      },
    );
  }
}
