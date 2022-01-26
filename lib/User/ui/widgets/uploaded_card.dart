import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';
import 'package:oliva/widgets/floating_button_edit.dart';

class UploadedCard extends StatelessWidget{

  final String category;
  final String pathImage;
  final double height;
  final double width; 
  final int calories;
  final bool internet;
  final String uid;
  UploadedCard(
    this.category,
    this.pathImage,
    this.height,
    this.width,
    this.calories,
    this.internet,
    this.uid
  );

  @override
  Widget build (BuildContext context) {

  

  var card =  InkWell(                 //Para crear un botón personalizado
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) { 
                      return RecipeScreen(uid);
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
                                      fontSize: 17.0,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                              ),
                        ]
                  ),
                ]
              )
            );
 
  return Stack(
      alignment: Alignment(0.9, 0.3),
      children: <Widget>[
        card,
        FloatingButtonEdit(uid),
      ],
    );
 }
}