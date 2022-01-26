import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/category_detail_screen.dart';
import 'package:oliva/User/ui/screens/objectives_list_screen.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';

class HomeScreenCard extends StatelessWidget{

  final String category;
  final String pathImage;
  final String type;
  final double height;
  final double width; 
  final int calories;
  final bool internet;
  final String uid;
  HomeScreenCard(
    this.category,
    this.pathImage,
    this.type,
    this.height,
    this.width,
    this.calories,
    this.internet,
    this.uid
  );

  
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

  return  InkWell(                 //Para crear un botón personalizado
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) { 
                    if(type == "category"){
                      return CategoryDetailScreen(category);
                    }
                    if(type == "objective"){
                      return ObjectivesListScreen(category,calories, "objective");
                    }
                    if(type == "quick"){
                      return ObjectivesListScreen(category,calories, "quick");
                    }
                    if(type == "popular"){
                      return RecipeScreen(uid);
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  }
                  )
                );
            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
            child:
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          height: height,
                          width: width,
                          margin: EdgeInsets.only(
                            left: 20.0,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                              image: internet?CachedNetworkImageProvider(pathImage):AssetImage(pathImage)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                            shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                            boxShadow: <BoxShadow>[                                     //crea la sombra del container
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 7.0)
                              ) 
                            ]
                          ),
                      ),
                      
                    ]
                  ),
                  Row(
                    children: <Widget>[                      
                             // Expanded(
                             //   child: 
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0
                                ),
                                width: width,
                                child:                            
                                  Text(
                                    category,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: textFont,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                              ),
                             // ),
                        ]
                  ),
                ]
              )
            );
  }
}