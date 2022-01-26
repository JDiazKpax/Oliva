import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/floating_button_fav.dart';

class RecipeFinalPhoto extends StatelessWidget{
  
  final RecipeDone recipe;
  RecipeFinalPhoto(this.recipe);

  @override
  Widget build(BuildContext context) {
    
    String pathImage = recipe.recipe[0].imgUrl;
    bool internet = recipe.recipe[0].internet;    
    double width = MediaQuery.of(context).size.width;
    double width1 = (width/2)-25.0;
         
    var recipePhoto = Container(    
                        height: 250.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                            image: internet?CachedNetworkImageProvider(pathImage):AssetImage(pathImage)
                          ),
                        ),      
                      );


  var title = Container(
              margin: EdgeInsets.only(
                  left:width1,
                  bottom: 20.0
                ),
              child:
                FloatingActionButtonGreen(recipe.recipe[0].name,"recipes")
              ); 

   
  var union = Container(    
          child: Column(            
            children: <Widget>[              
              Row(children: <Widget>[
                Column(
                   children: <Widget>[
                      title, 
                   ],
                ),                             
               ],
              ),             
            ]
            )
  ); 

  return Container(
                      child:
                        Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              recipePhoto
                              ],
                            ),
                            Row(children: <Widget>[
                              union
                              ],
                            ),
                          ]
                        )
                  );
 }
}