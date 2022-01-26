import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';

class ProfileHeader extends StatelessWidget{

  final DataBrought myData;
  ProfileHeader(this.myData);


  @override
  Widget build(BuildContext context) {
      var myName; 
     var myEmail;
     myName = myData.dataUser[0].name.split(" ");
     myEmail = myData.dataUser[0].email;
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
                 
    var userInfo = Container(
                    margin: EdgeInsets.only(
                  bottom: 20.0,
                ),         
                child: 
                 Column(
                   children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Container(  
                            alignment: Alignment(0.0,-1.0),    //Photo
                            margin: EdgeInsets.only(
                              top: 50.0,
                            ),
                            height: 120.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                 image: NetworkImage(myData.dataUser[0].photoURL), 
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
                                  top: 10.0,
                              //    left:20.0,                                          
                                ),
                                child:  
                                Text(
                                  "${myName[0]} ${myName[1]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF663300),
                                    fontSize: 25.0,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
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
                                    "$myEmail",
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
                   ],  
                  ),
              );

      return Stack(
        children: <Widget>[
          header,
          userInfo,
      ],);                      
   }
}