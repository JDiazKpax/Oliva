import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';

class RecipeTipsCard extends StatefulWidget{

  final String type; 
  final RecipeDone recipe;
  
  RecipeTipsCard(this.recipe, this.type);

  @override
  State createState() {    
        return _RecipeTipsCard();
  }
}

class _RecipeTipsCard extends State<RecipeTipsCard> {

  
  @override
  Widget build (BuildContext context) {
  
  var cardTotal = Container(
                    margin: EdgeInsets.only(
                      top: 15.0,
                      left: 10.0               
                    ),
                    child:
                    Column(
                      children: _cardContent(),                      
                    )
        );

  return Container(              
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
                left: 12.0,
                right: 15.0,
                ),
               decoration: BoxDecoration(               
                color: Color(0XFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                boxShadow: <BoxShadow>[                                     //crea la sombra del container
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 2.0)
                  ) 
                ]
              ),
              child:
              Column(                
                children: <Widget>[                  
                    cardTotal
                ],
              )
            );

  }

  Widget myCardTitle() {
      
      String title;

      if(widget.type == "tips"){
        title = "Tips y Claves: \n";
      }
      if(widget.type == "procedure"){
        title = "Manos a la Obra: \n";
      }
      if(widget.type == "serve"){
        title = "Servida y Presentación: \n";
      }
      return Row(
              children: <Widget>[                 
                    Column(
                      children: <Widget>[                          
                        Container(
                          child:                            
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF663300),
                                fontSize: 18.0,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ),
                      ],
                    ),
              ],
            );
  }

  Widget myCardContent(int i) {
    
  List text;

  if(widget.type == "tips"){    
    text = widget.recipe.recipe[0].tips;
  }
  if(widget.type == "procedure"){    
    text = widget.recipe.recipe[0].procedure;
  }
  if(widget.type == "serve"){    
    text = widget.recipe.recipe[0].serve;
  }
    
    return Container(
            margin: EdgeInsets.only(
              bottom: 15.0,
            ),
            child:
              Row(
              children: <Widget>[
                Expanded(                      
                  child:
                    Container(
                        margin: EdgeInsets.only(
                          bottom: 15.0,
                          right: 10.0
                        ),                            
                        child:     
                          Text(
                            "- ${text[i]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 16.0,
                              fontFamily: "Nunito",                                
                            ),
                          ),
                      ),
                ),
              ]
              ),
          );
  }

  List<Widget> _cardContent(){
    List<Widget> list = List();
    int myLength;
    list.add(myCardTitle());
    if(widget.type == "tips"){    
      myLength = widget.recipe.recipe[0].tips.length;
    }
    if(widget.type == "procedure"){    
       myLength = widget.recipe.recipe[0].procedure.length;
    }
    if(widget.type == "serve"){    
       myLength = widget.recipe.recipe[0].serve.length;
    }
    for(int i = 0; i < myLength; i++){
      list.add(myCardContent(i));
    }
    return list;
  }
}