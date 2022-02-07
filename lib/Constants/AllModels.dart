import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/Decorations.dart';

List<Color?> lesCols = [
  Colors.greenAccent[700],
  Colors.greenAccent[400],
  Colors.green[500],
  Colors.green[400],
  Colors.white,
  Colors.green[100],
  Colors.green[900],
  Colors.black
];

List tempcols = lesCols.toList();

// ignore: must_be_immutable
class TheTextpls extends StatelessWidget {
  TheTextpls({
    this.myicon,
    this.helper,
    required this.onPressed,
    required this.title,
    this.txt,
    required this.obstxt,
    this.txtcol,
    this.fillcol,
    this.bordcol,
    this.entertxt,
    this.fon,
  });
  final Function onPressed;
  final String title;
  final String? txt;
  final bool? entertxt;
  IconData? myicon;
  String? helper;
  bool obstxt;
  Color? bordcol;
  Color? txtcol;
  Color? fillcol;
  double? fon;

  @override
  Widget build(BuildContext context) {
    if (helper == null) {
      helper = "";
    }
    if (txtcol == null) {
      txtcol = lesCols[6];
    }
    if (fillcol == null) {
      fillcol = lesCols[5];
    }
    if (fon == null) {
      fon = 14;
    }
    if (bordcol == null) {
      bordcol = lesCols[0];
    }
    return TextField(
      autofocus: true,
      enabled: entertxt,
      onChanged: (value) => onPressed(value),
      cursorColor: lesCols[1],
      style:
          TextStyle(color: txtcol, fontFamily: "Manrope Light", fontSize: fon),
      obscureText: obstxt,
      decoration: Universe.txtplsdeco.copyWith(
          isDense: true,
          prefixIcon: Icon(
            myicon,
            color: lesCols[0],
            size: 30,
          ),
          helperText: helper,
          helperStyle: TextStyle(color: txtcol),
          hintText: title,
          errorText: txt,
          fillColor: fillcol,
          hintStyle: TextStyle(color: txtcol),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: bordcol!),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: txtcol!, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          )),
    );
  }
}

class PlayContainer extends StatelessWidget {
  PlayContainer(
      {required this.colorstart,
      required this.colorend,
      required this.coloricon,
      required this.colorsub,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.func});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color colorstart;
  final Color colorend;
  final Color coloricon;
  final Color colorsub;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border(
            left: BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 1.5),
            right: BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 1.5),
            top: BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 1.5),
            bottom: BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 1.5),
          ),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              Positioned(
                right: 5,
                top: 1,
                child: Icon(
                  icon,
                  size: 200,
                  color: coloricon,
                ),
              ),
              Positioned(
                top: 5,
                left: 4,
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Manrope Light",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 15,
                child: Text(
                  subtitle,
                  style: TextStyle(
                      fontFamily: "Manrope Light",
                      color: colorsub,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: Alignment.bottomRight,
                colors: [colorstart, colorend]),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}

class Favour extends StatelessWidget {
  Favour(
      { //required this.imageNetwork,
        required this.minDistance,
        required this.compensation,
        required this.maxDistance,
        required this.show,
        required this.title});

  final String title;
  final int compensation;
  final bool show;
  final int minDistance;
  final int maxDistance;


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              child: LayoutBuilder(builder: (context, constraint) {
                return new Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: constraint.biggest.height);
              }),
            ),
            Padding(padding: EdgeInsets.only(left: 5),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "\$"+compensation.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.white,
                              color: Colors.green[900]
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Text(
                          minDistance.toString()+" - "+maxDistance.toString()+"Km",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900]
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900]
                          ),
                        ),
                      ),
                    ]
                ),
              ),)
          ],
        ),
      ),
    );
  }
}

class CustAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text username;
  final dynamic profpic;
  final Color status;
  final List<Widget> actions;
  final Widget leading;

  CustAppBar(
      {required Key key,
      required this.username,
      this.profpic,
      required this.status,
      required this.actions,
      required this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          border: Border(
              bottom: BorderSide(
                  color: Colors.red, style: BorderStyle.solid, width: 1.5))),
      child: AppBar(
        elevation: 0,
        leading: leading,
        backgroundColor: Colors.green,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 10,
                    backgroundImage: AssetImage(profpic),
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                      child: CircleAvatar(),
                    )),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: CircleAvatar(
                    backgroundColor: status,
                    minRadius: 5,
                  ),
                )
              ],
            ),
            username
          ],
        ),
        actions: actions,
      ),
    );
  }

  final Size preferredSize = Size.fromHeight(kToolbarHeight + 5);
}

class Favour extends StatelessWidget{
  Favour({required this.title,
  required this.maxDistance,
  required this.compensation});

  final String title;
  final String compensation;
  final String maxDistance;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8
      ),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(25)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              child: LayoutBuilder(builder: (context, constraint){
                return new Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: constraint.biggest.height);
              }),
            ),
            Padding(padding: EdgeInsets.only(left: 5),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: 190,
                  child: Stack(
                      children: [
                        Positioned(
                          bottom: 2,
                          left: 5,
                          child: Text(
                            "\$"+compensation,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white,
                                color: Colors.green[900]
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Text(
                            maxDistance.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900]
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            title,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900]
                            ),
                          ),
                        ),
                      ]
                  ),
                )
              ),)
          ],
        ),
      ),
    );
  }
}
