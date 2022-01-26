import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/tip_screen.dart';

class FavTipsCard extends StatelessWidget{
  final String imgUrl;
  final String title;
  final String owner;
  final String uid;
  FavTipsCard(this.imgUrl, this.title, this.owner, this.uid);

  @override
  Widget build (BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   double divisor;
   double font;
    if(width > 450){
      divisor = 1.7;
      font = 16.0;
    }else{
      if(width < 350){ 
        divisor = 2.3;
        font = 13.0;
      }else{
        divisor = 2;
        font= 14.0;
      }
    }
   return Container(
          margin: EdgeInsets.only(
                top:30.0,
                left: 20.0,
              ),
          child:
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(                 //Para crear un botón personalizado
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => TipScreen(uid, "tips"),
                                )
                              );
                          },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                          child:                        
                        Container(
                          height: 100.0,
                          width: 110.0,
                          margin: EdgeInsets.only(
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                              image: CachedNetworkImageProvider(imgUrl)
                            ),
                            shape: BoxShape.circle,                                  //la forma del containe debe ser rectangular
                            boxShadow: <BoxShadow>[                                     //crea la sombra del container
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 7.0)
                              ) 
                            ]
                          ),
                       )
                        )
                      ]
                    ),
                   Container(
                     width: width/divisor,
                     child: 
                    Column(
                      children: <Widget>[
                        Row(                          
                          children: <Widget>[ 
                            Flexible(
                                child: 
                              InkWell(                 //Para crear un botón personalizado
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => TipScreen(uid, "tips"),
                                    )
                                  );
                              },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                              child: 
                                Text(
                                  title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF663300),
                                    fontSize: font,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  ),                                  
                              ),                              
                              )                            
                          ],                        
                        ),
                       //),
                       Row(
                        children: <Widget>[                                         
                              Flexible(
                                child:     
                                  Text(
                                    "por: $owner",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: font,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                              ),
                          ],
                        ),
                      ]
                    ),
                    ),
                    
                  ]
                 )
  //        )
        );
  }
}