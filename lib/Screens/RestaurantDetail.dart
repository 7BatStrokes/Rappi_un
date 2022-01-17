import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rappi_un/Constants/AllModels.dart';

class RestaurantDetail extends StatelessWidget {
  static const String id = 'RestaurantDetail';
  DocumentSnapshot snapshot;
  RestaurantDetail(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lesCols[5],
        appBar: AppBar(
          backgroundColor: lesCols[6],
          centerTitle: true,
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
            minimum: EdgeInsets.all(25),
            child: Column(children: [
              Row(
                children: [SizedBox(width: 50,),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FadeInImage.assetNetwork(
                            placeholder: 'images/loading.gif',
                            image: snapshot.get("imagen"),
                          ).image,
                        ),
                  ),
                  ),
                Column(children: [
                  Text(snapshot.get("nombre")),
                  Text(snapshot.get("direccion")),
                  Row(
                    children: [SizedBox(width: 15,),if (snapshot.get("estrellas")>0) buildStar() ,SizedBox(width: 3,),if (snapshot.get("estrellas")>1) buildStar()
                      ,SizedBox(width: 3,), if (snapshot.get("estrellas")>2) buildStar(),
                      SizedBox(width: 3,),if (snapshot.get("estrellas")>3) buildStar(),SizedBox(width: 3,),
                      if (snapshot.get("estrellas")>4) buildStar()],
                  ),
                ],),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                height: 72,

                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(snapshot.get("descripcionLarga"),
                ),
                ),
              ),

              Divider(height: 15,thickness: 3,color: Colors.black,),
              Text("Platillos"),
              Expanded(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 20),
                      itemCount: snapshot.get("platillos").length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            children: [Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FadeInImage.assetNetwork(
                                    placeholder: 'images/loading.gif',
                                    image: snapshot.get("platillos")[index]["imagen"],
                                  ).image,
                                ),
                              ),
                            ),
                              Text(snapshot.get("platillos")[index]["nombre"]),
                            ],
                          )


                        );
                      }
                  )
              )
            ])
        ),




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
