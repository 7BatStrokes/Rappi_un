import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Screens/Chat.dart';
import 'package:rappi_un/Screens/EstadoPedido.dart';
import 'package:rappi_un/Screens/Favores.dart';
import 'package:rappi_un/Screens/Home.dart';
import 'package:rappi_un/Screens/Welcome.dart';
import 'package:rappi_un/Screens/Choose.dart';
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
        MyHome.id: (context) => MyHome(),
        Chat.id: (context) => Chat(),
        Choose.id: (context) => Choose(),
        Favores.id: (context) => Favores(),
        Estado.id: (context) => Estado(),
      },
    );
  }
}
