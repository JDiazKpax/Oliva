import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';

class RecommendedToday extends StatelessWidget{

  final RecommendedTodayDone recommended;

  RecommendedToday(this.recommended); 

  @override
  Widget build(BuildContext context) {
    String pathImageB = recommended.recommendedToday[0].pathImageB;
    String pathImageL = recommended.recommendedToday[0].pathImageL;
    String pathImageD = recommended.recommendedToday[0].pathImageD;
    bool internet = recommended.recommendedToday[0].internet;
    String uidB = recommended.recommendedToday[0].uidB;
    String uidL = recommended.recommendedToday[0].uidL;
    String uidD = recommended.recommendedToday[0].uidD;
    final width = MediaQuery.of(context).size.width;
    double divisor;
    if(width > 420){
      divisor = 150.0;
    }else{
      if(width < 340){
        divisor = 105.0;
      }else{
        divisor = (width*150.0)/400.0;
      }
    }

     return  Container(              
             margin: EdgeInsets.only(
                top: 10.0,
              ),
             child:
               Column(
                  children: <Widget>[ 
                      Row(
                        children: <Widget>[                                                     
                              Container(
                              margin: EdgeInsets.only(
                                  left:20.0
                                ),
                              child:
                                Text("Recomendados del día",
                                textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF663300),
                                    fontSize: 20.0,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700)),
                                    
                              ),
                           ],
                       ),                  
                      Row(
                        children: <Widget>[
                          Expanded(
                          child:
                           InkWell(                 //Para crear un botón personalizado
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => RecipeScreen(uidB),
                                  )
                                );
                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                            child:
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20.0,
                                  left:0.0
                                ),
                                height: divisor,
                                decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: internet?CachedNetworkImageProvider(pathImageB):AssetImage(pathImageB) 
                                  ),
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
                           InkWell(                 //Para crear un botón personalizado
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => RecipeScreen(uidL),
                                  )
                                );
                            },
                            child:
                           Container(
                            height: divisor,
                            decoration: BoxDecoration(
                            image: DecorationImage(
                               fit: BoxFit.fitWidth,
                               image: internet?CachedNetworkImageProvider(pathImageL):AssetImage(pathImageL) 
                              ),
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
                           InkWell(                 //Para crear un botón personalizado
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => RecipeScreen(uidD),
                                  )
                                );
                            },
                            child:
                            Container(
                              height: divisor,
                              decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: internet?CachedNetworkImageProvider(pathImageD):AssetImage(pathImageD) 
                                ),
                              ),      
                            ),
                           ),
                           ),
                        ],
                       ),
                      ],
                    ), 
           );    
          }
}