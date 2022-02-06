import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/icons/awesome5_icons.dart';


class EstadoPedidoCompra extends StatefulWidget {
  static const String id = 'EstadoPedidoCompra';
  final int precio;
  final String objeto;
  const EstadoPedidoCompra({Key? key, required this.precio, required this.objeto})
      : super(key: key);

  @override
  _TheAppState createState() => _TheAppState();

}

class _TheAppState extends State<EstadoPedidoCompra> {
  @override
  Widget build(BuildContext context) {
    double _value = 0;
    // Aca se construye la escena que se ve
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
          title: Text("Estado del Pedido"),
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
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
            child: Column(
              children: [
                Image(image: AssetImage('images/loading.gif')),
                Text("Tu pedido:\n"+ widget.objeto),
                Text("Con un valor de: "+ widget.precio.toString()),
                Text("Tu pedido esta: "),
                Slider(
                  divisions: 3,
                  label: "Estado: ",
                  min: 0,
                  max: 15,
                  value: _value,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Text("Habla con nuestro repartidor! "),
                IconButton(
                  iconSize: 15,
                  icon: const Icon(
                      Awesome5.snapchat),
                  onPressed: () {
                  

                  }
                  ),

              ],
            ),
          ),
        )
    );
  }
}