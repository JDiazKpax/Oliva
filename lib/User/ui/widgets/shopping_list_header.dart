import 'package:flutter/material.dart';

class ShoppingListHeader extends StatelessWidget{
  
  final String title;
  ShoppingListHeader(this.title);

  @override
  Widget build(BuildContext context) {
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
              
    
  var headerTotal = Container(
                      child:
                        Column(
                          children: <Widget>[
                            header,                            
                          ]
                        )
                  );

  var recipeCategoryInfo = Container(
          child:
           Column(
             children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                        Container(  
                        margin: EdgeInsets.only(
                          top: 20.0,
                        ),  
                        child:        
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 25.0,
                              fontFamily: "Nunito",                                        
                            ), 
                          ),
                        ),
                    ),
                  ],
                ), 
             ]
           )
        );  

      return Container(
        margin: EdgeInsets.only(
          bottom: 30.0,
        ),
        child: Column(
          children: <Widget>[
              headerTotal,
              recipeCategoryInfo              
            ],
        )
      );
   }
}