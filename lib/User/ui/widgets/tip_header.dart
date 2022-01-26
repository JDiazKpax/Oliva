import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/floating_button_fav.dart';

class TipHeader extends StatelessWidget{
  
  final TipDone data;
  TipHeader(this.data);

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
                 
    var tipPhoto = Container(
                        margin: EdgeInsets.only(
                          top: 0.0,
                          bottom: 20.0,
                        ),         
                        height: 190.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(data.tip[0].pathImage), 
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
                                alignment: Alignment(0.9, 1.1),
                                children: <Widget>[
                                  tipPhoto,
                                  FloatingActionButtonGreen(data.tip[0].uid, "tips"),
                             ],
                              )
                              ],
                            ),
                          ]
                        )
                    );

  var tipInfo = 
    Container(
          margin: EdgeInsets.only(
                left: 20.0,
          ),
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
                          left: 20.0
                        ),  
                        child:        
                          Text(
                            data.tip[0].title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 20.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700                                        
                            ), 
                          ),
                        ),
                    ),
                  ],
                ), 
                Row(
                  children: <Widget>[
                     Column(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 50.0,
                          margin: EdgeInsets.only(
                            top: 10.0,
                            right: 15.0,
                            left: 20.0
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                              image: CachedNetworkImageProvider(data.tip[0].imgChef),
                            ),
                            shape: BoxShape.circle,                                  //la forma del containe debe ser rectangular
                            boxShadow: <BoxShadow>[                                     //crea la sombra del container
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 5.0,
                                offset: Offset(0.0, 2.0)
                              ) 
                            ]
                          ),
                       )
                      ]
                    ),                  
                    //Expanded(
                    // child:
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[                               
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15.0,
                                  ),
                                  child:                            
                                    Text(
                                    data.tip[0].owner,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 19.0,
                                      fontFamily: "Nunito",
                                    ),
                                    ),
                                ),
                            ],
                          ),
                        ]
                     // ),
                     ),
                  ]
                 )
             ]
           )

        );  

      return 
        Container(
        margin: EdgeInsets.only(
          bottom: 30.0,
        ),
        child: Column(
          children: <Widget>[
              headerTotal,
              tipInfo              
            ],
        )
      );
   }
}