import 'package:flutter/material.dart';
import 'package:oliva/User/ui/widgets/home_screen_card.dart';

class ObjectivesList extends StatelessWidget{

 @override
 Widget build(BuildContext context) {  

  var title = InkWell(                 //Para crear un botón personalizado
                onTap: () {
                  
                },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                child:
                  Container(
                  margin: EdgeInsets.only(
                      top: 30.0,
                      left: 20.0
                    ),
                  child:
                    Text("Objetivos Sostenibles",
                    textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF663300),
                        fontSize: 20.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700)),
                  ),
                  );         
              
  var list = Container(
              height: 350.0,
              child: ListView(
                padding: EdgeInsets.all(30.0),
                scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                children: <Widget>[
                  HomeScreenCard("Hasta 100 Calorías","assets/img/100Calories.jpg","objective",250.0,250.0,100,false,""),
                  HomeScreenCard("Hasta 200 Calorías","assets/img/200Calories.jpg","objective",250.0,250.0,200,false,""),
                  HomeScreenCard("Hasta 300 Calorías","assets/img/300Calories.jpg","objective",250.0,250.0,300,false,""),
                  HomeScreenCard("Hasta 400 Calorías","assets/img/400Calories.jpg","objective",250.0,250.0,400,false,""),
                  HomeScreenCard("Hasta 500 Calorías","assets/img/500Calories.jpg","objective",250.0,250.0,500,false,""),
                ],
               ),
              );
  
  var union = Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                title,                
              ],),
              list
            ]
          )
  ); 

  return union;
 }
}