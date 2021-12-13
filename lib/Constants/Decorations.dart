import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

//All Variables that would be repeated over and over
class Universe {
  static const txtplsdeco = InputDecoration(
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintStyle: TextStyle(
        fontFamily: "Manrope Light",
        fontWeight: FontWeight.normal,
        fontSize: 13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
