import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/ChooseFavor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:rappi_un/Screens/EstadoPedidoCompra.dart';

final _firestore = FirebaseFirestore.instance;
FireRepo _firerepo = FireRepo();
User user = FirebaseAuth.instance.currentUser!;
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
final ImagePicker _picker = ImagePicker();

class Myform extends StatefulWidget {
  static const String id = 'Form';
  String myStr = 'hola1';
  @override
  _TheAppState createState() => _TheAppState();
}

bool IsAString(String a){
  bool respuesta = false;
  String b = '0123456789';
  for(int i = 0 ; i < a.length ; i++){
    for(int j = 0 ; j < b.length ; j++){
      if(a[i]==b[j]){
        respuesta = true;
        break;
      }
      else{
        respuesta = false;
      }
    }
    if(respuesta == false){
      return respuesta;
    }
  }
  return respuesta;
}

class _TheAppState extends State<Myform> {
  double _value = 1;
  final controler1 = TextEditingController();
  final controler2 = TextEditingController();
  String slider = "";
  var _image;
  final controler3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Aca se construye la escena que se ve
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
          title: Text("Petición Especial"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                    builder: (_) => new AlertDialog(
                      title: Text("Foto",textAlign: TextAlign.center,),
                      content: Text("¿Podrias aclararnos si tomaras una foto o accedera a ella por medio de la galeria?"),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () async {
                            final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                            setState(() {
                              if(image != null){
                                _image = File(image.path);
                              }else{
                                print('Image is not selected');
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: new Text('Camara'),
                        ),
                        new FlatButton(
                          onPressed: () async {
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            setState(() {
                              if(image != null){
                                _image = File(image.path);
                              }else{
                                print('Image is not selected');
                              }
                            });
                            Navigator.of(context).pop();
                            },
                          child: new Text('Galeria'),
                        ),
                      ],
                    ),);
                  //final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('¿Qué necesitas?',
                  style: TextStyle(
                  color: lesCols[6],
                  fontSize: 20,
                  fontFamily: "Agrandir Text Bold",
                  ),
                ),
                TextField(
                  controller: controler1,
                  autocorrect: true,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: lesCols[7]),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                Spacer(),
                Text('¿Donde se puede conseguir?',
                  style: TextStyle(
                    color: lesCols[6],
                    fontSize: 20,
                    fontFamily: "Agrandir Text Bold",
                  ),
                ),
                TextField(
                  controller: controler2,
                  autocorrect: true,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: lesCols[7]),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                Spacer(),
                Text('Determinar el rango de distancia',
                  style: TextStyle(
                    color: lesCols[6],
                    fontSize: 20,
                    fontFamily: "Agrandir Text Bold",
                  ),
                ),
                new Slider(
                  divisions: 3,
                  label: "< "+_value.round().toString()+" km",
                  min: 0,
                  max: 15,
                  value: _value,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value;
                    });
                    slider = "< "+_value.round().toString()+" km";
                  },
                ),
                Spacer(),
                Text('¿Qué precio pagaras?',
                  style: TextStyle(
                    color: lesCols[6],
                    fontSize: 20,
                    fontFamily: "Agrandir Text Bold",
                  ),
                ),
                TextField(
                  controller: controler3,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: lesCols[7]),
                  decoration: InputDecoration(
                    hintText: 'COP',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                      color: Color(0xFFbdc6cf),
                    ),
                    contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: (){
                    if(!IsAString(controler3.text)){
                      showDialog(context: context, builder: (_) => new AlertDialog(
                        content: Text("Por favor, ingresa únicamente un valor entero, sin ningún caracter adicional"),
                      ));
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: Text("¿Estas seguro de subir la petición?",textAlign: TextAlign.center,),
                          content: Text(controler1.text+"\n"+controler2.text+"\n"+slider+"\n"+controler3.text),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () async{
                                var name='';
                                if(_image != null){
                                  try{
                                    var timeKey = DateTime.now();
                                    await firebase_storage.FirebaseStorage.instance.ref('imagenes').child(timeKey.toString()).putFile(_image);
                                    name = timeKey.toString();
                                  }catch (e) {
                                    //
                                  }
                                }
                                _firestore.collection("peticiones").add({
                                  'objeto': controler1.text,
                                  'lugar': controler2.text,
                                  'distancia': slider,
                                  'precio': controler3.text,
                                  'imagen': name,
                                  'solicitante':  user.email,
                                  'repartidor': '',
                                });
                                Navigator.push(context, // Navega a la siguiente ruta llamda myHome reemplazando la ventana actual
                                    MaterialPageRoute(builder: (context) {
                                      return EstadoPedidoCompra(precio: int.parse(controler3.text), objeto: controler1.text);
                                    }));
                              },
                              child: new Text('Confirmar'),
                              textColor: Colors.blue,
                            ),
                            new FlatButton(
                              onPressed: () {Navigator.of(context).pop();},
                              child: new Text('Cancelar'),
                              textColor: Colors.red,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Publicar",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: lesCols[4],
                      fontSize: 20,
                      fontFamily: "Agrandir Text Bold",
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: lesCols[6],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: <Widget>[
// Text('Customer Contact',
// style: TextStyle(
// color: lesCols[6],
// fontSize: 20,
// fontFamily: "Agrandir Text Bold",
// ),),
// TextField(
// cursorColor: Colors.white,
// decoration: InputDecoration(hintText: 'Enter here'),
// )
// ],
// ),