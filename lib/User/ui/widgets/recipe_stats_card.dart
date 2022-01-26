import 'package:flutter/material.dart';

class RecipeStatsCard extends StatelessWidget{

  final String number; 
  final String text;
  final double width;

  RecipeStatsCard({
    Key key, 
    @required this.number,
    @required this.text,
    @required this.width});
  
  @override
  Widget build (BuildContext context) {

     double systemSize = MediaQuery.of(context).textScaleFactor;
    double textFont = 18.0;
  if(systemSize > 1){
      textFont = 13.0;
    }
  if(systemSize > 1.4){
      textFont = 13.0;
    }

  var cardBackground =  Container(
              height: 80.0,
              width: width,
              margin: EdgeInsets.only(
                bottom: 15.0,
                right: 10.0
              ),
              decoration: BoxDecoration(               
                color: Color(0xFFE8FDFF), 
                borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                boxShadow: <BoxShadow>[                                     //crea la sombra del container
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 2.0)
                  ) 
                ]
              ),
          );

  var cardInside =  Container(
              width: width,
               margin: EdgeInsets.only(
                top: 15.0,               
              ),
              child:
              Column(
                children: <Widget>[                   
                  Row(
                    children: <Widget>[                 
                      Expanded(
                        child:
                        Container(
                          child:                            
                            Text(
                            number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 25.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                  children: <Widget>[                                         
                       Expanded(
                        child:
                        Container(
                          child:     
                            Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF663300),
                                fontSize: textFont,
                                fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              ),
                            ),
                        ),
                       ),
                    ],
                  ),
                ],
              )
          );

  var union = Stack(
        children: <Widget>[
          cardBackground,
          cardInside            
         ],
        );

  return union;

  }
}