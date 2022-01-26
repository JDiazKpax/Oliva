import 'package:flutter/material.dart';
import 'package:oliva/User/ui/widgets/home_screen_card.dart';

class QuickRecipesList extends StatelessWidget{

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
                    Text("Recetas Rápidas",
                    textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF663300),
                        fontSize: 20.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700)),
                  ),
                  );         
              
  var list = Container(
              height: 300.0,
              child: ListView(
                padding: EdgeInsets.all(30.0),
                scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                children: <Widget>[
                  HomeScreenCard("Menos de 10 minutos","assets/img/100Calories.jpg","quick",200.0,200.0,10,false,""),
                  HomeScreenCard("Menos de 20 minutos","assets/img/200Calories.jpg","quick",200.0,200.0,20,false,""),
                  HomeScreenCard("Menos de 30 minutos","assets/img/300Calories.jpg","quick",200.0,200.0,30,false,""),
                  HomeScreenCard("Menos de 40 minutos","assets/img/400Calories.jpg","quick",200.0,200.0,40,false,""),
                  HomeScreenCard("Menos de 60 minutos","assets/img/500Calories.jpg","quick",200.0,200.0,60,false,""),
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