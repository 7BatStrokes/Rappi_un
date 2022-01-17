import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';
import 'package:rappi_un/Screens/RestaurantDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';
final _firestore = FirebaseFirestore.instance;

FireRepo _firerepo = FireRepo();
String vista = 'Selecciona una opcion';

class Restaurants extends StatefulWidget {
  static const String id = 'Restaurants';

  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<Restaurants> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Aca se construye la escena que se ve
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
          title: Text("Restaurantes"),
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
            padding: EdgeInsets.only(top: 15, bottom: 30, left: 15, right: 15),
            child: FutureBuilder(
                future: _firerepo.getRestaurants(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 20),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Aca se construye lo que sea que quiero el numero de item cuonts veces

                          return Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Color(0xFFAAE690),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            child: BodyList(snapshot,index)
                          );
                        });
                  }
                }),
          ),
        ));
  }
}

class BodyList extends StatelessWidget {
AsyncSnapshot snapshot;
int index;
BodyList(this.snapshot,this.index);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 95,
        height: 82,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: FadeInImage.assetNetwork(
                  placeholder: 'images/loading.gif',
                  image: snapshot.data[index]["imagen"],
                ).image,
            )
        ),
      ),
      Container(
        width: 155,
        height: 120,
        child: Column(children: [
          Text(snapshot.data[index]["nombre"] ,
              style: TextStyle(
                color: lesCols[6],
                fontSize: 20,
                fontFamily: "Agrandir Text Bold",
              )
          ),
          SizedBox(height: 3),
          Container(
            height: 65,
            child:Text(snapshot.data[index]["descripcion"],
                textAlign: TextAlign.justify,
              style:TextStyle(
              color: Colors.black,
              fontSize: 13.5,
              fontFamily: "MyFlutterApp",
            ),
            )
          ),
         Row(
           children: [SizedBox(width: 15,),if (snapshot.data[index]["estrellas"]>0) buildStar() ,SizedBox(width: 3,),if (snapshot.data[index]["estrellas"]>1) buildStar()
             ,SizedBox(width: 3,), if (snapshot.data[index]["estrellas"]>2) buildStar(),
             SizedBox(width: 3,),if (snapshot.data[index]["estrellas"]>3) buildStar(),SizedBox(width: 3,),
           if (snapshot.data[index]["estrellas"]>4) buildStar()],
         )

        ]),
      ),
      SizedBox(width: 7),
      Container(
         child: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantDetail(snapshot.data[index])));
            },
      )),
    ]
      );
  }
}

class buildStar extends StatelessWidget {
  const buildStar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
    Icons.star,
      size: 25,
      color: Colors.yellowAccent[700],

    );
  }
}
