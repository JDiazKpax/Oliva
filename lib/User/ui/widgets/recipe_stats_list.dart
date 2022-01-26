import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/recipe_stats_card.dart';

class RecipeStatsList extends StatelessWidget{

  final RecipeDone recipe;
  RecipeStatsList(this.recipe);

 @override
 Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double mitad = width/2.3;
  double tercio = width/3.55;
  String time = recipe.recipe[0].time;
  String likes = recipe.recipe[0].likes.toString();
  String ingredientsNumber = recipe.recipe[0].ingredientsNumber.toString();
  String difficulty = recipe.recipe[0].difficulty;
  String calories = recipe.recipe[0].calories.toString();
  double divisor1;
  double divisor2;
    if(width > 400){
      divisor1 = mitad;
      divisor2 = tercio;
    }else{
      if(width < 340){
        divisor1 = mitad/1.05;
        divisor2 = tercio/1.05;
      }else{
        divisor1 = mitad/1.02;
        divisor2 = tercio/1.03;
      }
    }

  var list = Container(
              margin: EdgeInsets.only(
                top: 30.0,
                left: 20.0,
                right: 10.0
               ),
               child:Column(
                 children: <Widget>[ 
                   Row(
                     children: <Widget>[
                       RecipeStatsCard(number: time, text: "Tiempo", width: divisor1),
                       RecipeStatsCard(number: calories, text: "Calorías", width: divisor1),
                     ]
                   ),                
                   Row(
                     children: <Widget>[
                       RecipeStatsCard(number: ingredientsNumber, text: "Ingredientes", width: divisor2),
                       RecipeStatsCard(number: difficulty, text: "Dificultad", width: divisor2),
                       RecipeStatsCard(number: likes, text: "Likes", width: divisor2)
                     ]
                   ),
                 ]
                )
               
              );
  
  return Container(
          child: list
  ); 

 }
}