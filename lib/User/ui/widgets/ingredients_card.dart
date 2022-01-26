import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IngredientsCard extends StatelessWidget{

  final String pathImage;
  final String title;

  IngredientsCard(this.title, this.pathImage);

  @override
  Widget build (BuildContext context) {
     double systemSize = MediaQuery.of(context).textScaleFactor;
    double textFont = 16.0;
  if(systemSize > 1){
      textFont = 14.0;
    }
  if(systemSize > 1.4){
      textFont = 13.0;
    }

  return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      margin: EdgeInsets.only(
                        left: 30.0,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,       
                          image: CachedNetworkImageProvider(pathImage)
                        ),
                        shape: BoxShape.circle,   
                      ),
                  ),                      
                  ]
                ),
                Row(
                  children: <Widget>[                      
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.0,
                                left: 20.0
                              ),
                              width: 100.0,
                              child:                            
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF663300),
                                    fontSize: textFont,
                                    fontFamily: "Nunito",
                                  ),
                                ),
                            ),
                      ]
                ),
              ]
            );
          }
}