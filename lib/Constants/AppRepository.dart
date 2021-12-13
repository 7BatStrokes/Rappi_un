import 'package:flutter/cupertino.dart';
import 'package:rappi_un/Constants/AppMethods.dart';

class AppRepo {
  AppMethods _appMethods = AppMethods();
  String givemedatepls() => _appMethods.givemedatepls();
  String givemeabetterdatenow(List<String> gg) =>
      _appMethods.givemeabetterdatenow(gg);
  bool wording(String users, String user) => _appMethods.wording(users, user);
  String trimstr(String a) => _appMethods.trimstr(a);
  List<Widget> profilepics() => _appMethods.profilepics();
  Future<bool> wordingNew(String a, String b) => _appMethods.wordingNew(a, b);
}
