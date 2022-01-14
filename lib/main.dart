import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Screens/Home.dart';
import 'package:rappi_un/Screens/Welcome.dart';
import 'package:rappi_un/Screens/Register.dart';
import 'package:rappi_un/Screens/Choose.dart';
import 'package:rappi_un/Screens/Check.dart';

void main() async {
  //Este main inicializa el proyecto y conecta a firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Rappi());
}

class Rappi extends StatelessWidget {
  // Widget personalizado que fue creado para retornar ... algo
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita el modo debug
      initialRoute: Check.id, // Define la ruta principal donde se inicia el programa
      routes: { // Define las otras rutas
        Check.id: (context) => Check(),
        Welcoming.id: (context) => Welcoming(),
        Register.id: (context) => Register(),
        MyHome.id: (context) => MyHome(),
      },
    );
  }
}
