import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/Choose.dart';
import 'package:rappi_un/Screens/MainMenu.dart';
import 'package:rappi_un/Screens/Welcome.dart';

// ignore: must_be_immutable
class Check extends StatelessWidget {
  static const String id = "Check";
  FireRepo _repo = FireRepo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _repo.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return snapshot.hasData ? Menu(0) : Welcoming();
        });
  }
}
