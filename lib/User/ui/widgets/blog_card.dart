import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/tip_screen.dart';

class BlogCard extends StatelessWidget{

  final TipTodayDone data;
  final int index;
  BlogCard(this.data, this.index);

  @override
  Widget build (BuildContext context) {
  String pathImage = data.tipToday[index].pathImage;
  var image = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(                 //Para crear un botón personalizado
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TipScreen(data.tipToday[index].uid, "blogs"),
                          )
                        );
                    },
                    child:  
                    Container(
                    margin: EdgeInsets.only(
                      top: 0.0,
                      bottom: 30.0
                    ),
                    height: 100.0,
                    width: 196.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(pathImage),
                      ),
                    ),      
                  ),
                  )
                 ],
              );
  double systemSize = MediaQuery.of(context).textScaleFactor;
    double fontText = 18.0;
     if(systemSize > 1){
      fontText = 15.0;
    }
  if(systemSize > 1.4){
      fontText = 14.0;
    }

    var blogTitle = Row(
                    children: <Widget>[
                      Expanded(child:
                        InkWell(                 //Para crear un botón personalizado
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => TipScreen(data.tipToday[index].uid, "blogs"),
                                )
                              );
                          },
                          child:
                            Container(
                            margin: EdgeInsets.only(
                              bottom: 10.0
                            ),
                            child:
                              Text(data.tipToday[index].title,
                              textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: fontText,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Nunito")),
                            ),
                         ),
                        ),
                    ],
                  );    

    var blogUser = Row(
                    children: <Widget>[
                      Expanded(child: 
                      Container(
                      child:
                        Text(
                        "por: " + data.tipToday[index].owner,
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF663300),
                            fontSize: 15.0,
                            fontFamily: "Nunito")),
                      ),
                    ),
                    ],
                  );


    return Container(              
              height: 250.0,
              width: 200.0,
              margin: EdgeInsets.only(
                bottom: 20.0,
                left: 12.0,
                right: 12.0,
                ),
              decoration: BoxDecoration(               
                borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                 border: Border.all(
                  color: Color(0xFF58F3EC),
                  width: 2.0, 
                  style: BorderStyle.solid,
                ),
                shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                boxShadow: <BoxShadow>[                                     //crea la sombra del container
                  BoxShadow(
                    color: Color(0xFFE8FDFF),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 8.0)
                  ) 
                ]
              ),
              child:
              Column(
                children: <Widget>[
                    image,
                    blogTitle,
                    blogUser,               
                ],
              )
            );
  }
}