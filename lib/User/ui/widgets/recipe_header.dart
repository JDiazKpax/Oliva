import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/floating_button_fav.dart';

class RecipeHeader extends StatelessWidget{
  
  final RecipeDone recipe;
  RecipeHeader(this.recipe);

  @override
  Widget build(BuildContext context) {
    
    String pathImage = recipe.recipe[0].imgUrl;
    bool internet = recipe.recipe[0].internet;
    String recipeName = recipe.recipe[0].name;
    String recipeCategory = recipe.recipe[0].category;
    String owner = recipe.recipe[1].ownerName;
    String description = recipe.recipe[0].description;
    final width = MediaQuery.of(context).size.width;
    double divisor;
    if(width > 420){
      divisor = 220.0;
    }else{
      if(width < 340){
        divisor = 155.0;
      }else{
        divisor = (width*220.0)/400.0;
      }
    }
     
     var header =  Container(
              decoration: BoxDecoration(               
                color: Color(0xFFC6FAFF),
              ), 
              padding: EdgeInsets.only(bottom: 20.0),
              child:     
              Column(
              children: <Widget>[                   
                  Row(
                    children: <Widget>[
                    Expanded(
                     child:
                      Column(
                        children: <Widget>[                        
                          Row(children: <Widget>[                          
                            GestureDetector(                           
                              onTap: () {
                                Navigator.pop(
                                    context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30.0, left: 20.0),
                                child:Icon(Icons.arrow_back_ios, size: 35)
                              ),
                            ),
                          ],
                          ),
                         ],
                        ),
                      ),
                      
                       Column(                           
                          children: <Widget>[                        
                           Row(  //logo2
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[                      
                                    Container(
                                      alignment: Alignment(0.0,0.0),                                
                                      margin: EdgeInsets.only(
                                        top:30.0,
                                        right:30.0,
                                        bottom: 0.0
                                      ),
                                      height: 50.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/img/logo2.png"), 
                                        ),
                                      ),      
                                    ),
                                ],
                          ),
                         ],  
                       ),
                       ],
                   ),
                   Row(children: <Widget>[],)
              ]
              )
            );   
                 
    var recipePhoto = Container( 
                        margin: EdgeInsets.only(
                          bottom: 20.0,
                        ),         
                        height: divisor,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: internet?CachedNetworkImageProvider(pathImage):AssetImage(pathImage)
                          ),
                        ),      
                      );

  var headerTotal = Container(
                      child:
                        Column(
                          children: <Widget>[
                            header,
                            Row(children: <Widget>[
                              Stack(
                                alignment: Alignment(0.9, 1.0),
                                children: <Widget>[
                                  recipePhoto,
                                  FloatingActionButtonGreen(recipeName,"recipes"),
                                ],
                              )
                              ],
                            ),
                          ]
                        )
                    );

 var name =  Container(child:
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container( 
                                width: 300.0,
                                height: 50.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(               
                                    color: Color(0xFFE8FDFF), 
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),      //borde redondeado
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 0.0,
                                      style: BorderStyle.solid,
                                    ),
                                    shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                                    boxShadow: <BoxShadow>[                                     //crea la sombra del container
                                      BoxShadow(
                                        color: Color(0XFF000000),
                                        blurRadius: 15.0,
                                        offset: Offset(0.0, 2.0)
                                      ) 
                                    ]
                                  ),      
                                margin: EdgeInsets.only(
                                  top: 310.0,
                                  right: 0.0,
                                  bottom: 0.0
                                ),
                                child: Text(
                                        recipeName,
                                        textAlign: TextAlign.center,                                    
                                        style: TextStyle(
                                        color: Color(0xFF663300),
                                        fontSize: 18.0,
                                        fontFamily: "Nunito",
                                        ),  
                                      ),                             
                              ),    
                          ],
                          ),
                         ],
                        ),
                    );

   var recipeInfo = Container(  
                    margin: EdgeInsets.only(
                      top: 380.0,
                    ),  
                    child: Column(
                      children: <Widget> [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: 
                                Container(
                                    margin: EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    child:  
                                    Text(
                                      "Categoría: $recipeCategory",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF663300),
                                        fontSize: 19.0,
                                        fontFamily: "Nunito",                                        
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
                                        "por: $owner",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF663300),
                                          fontSize: 18.0,
                                          fontFamily: "Nunito",
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
                                      margin: EdgeInsets.only(
                                       top: 20.0,
                                       left: 10.0,
                                       right: 10.0
                                      ),
                                      child:  
                                      Text(
                                        description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF663300),
                                          fontSize: 19.0,
                                          fontFamily: "Nunito",
                                        ), 
                                      ),
                                    ),
                            ),
                          ],
                        ), 
                    ],  
                  ),
              );

      return Stack(
        children: <Widget>[
          headerTotal,
          name,
          recipeInfo
        ],
      );
   }
}