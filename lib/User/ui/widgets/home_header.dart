import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/model/auth_events.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/profile_screen.dart';
import 'package:oliva/User/ui/screens/menu_screen.dart';

class HomeHeader extends StatelessWidget{

  final DataBrought myData; 
  HomeHeader(this.myData); 

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    var myName;
    myName = myData.dataUser[0].name.split(" ");
    final width = MediaQuery.of(context).size.width;
    double divisor;
    if(width > 400){
      divisor = 3.5;
    }else{
      if(width < 340){
        divisor = 55;
      }else{
        divisor = 4;
      }
    }
    return  Container(              
               margin: EdgeInsets.only(
                bottom: 40.0,
                ),
                padding: EdgeInsets.only(bottom:20.0),
              decoration: BoxDecoration(               
                color: Color(0xFFC6FAFF),
              ), 
              child:     
              Column(
              children: <Widget>[                   
                  Row(
                    children: <Widget>[
                    Expanded(
                     child:
                      Column(
                          children: <Widget>[                        
                           Row(  //Menu
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[                      
                                  InkWell(                 //Para crear un botón personalizado
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => MenuScreen(myData),
                                          )
                                        );
                                    },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                                    child:
                                    Container(
                                      alignment: Alignment(0.0,0.0),                                
                                      margin: EdgeInsets.only(
                                        top: 20.0,
                                        left:0.0
                                      ),
                                      height: 40.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/img/menu.png"), 
                                        ),
                                      ),      
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
                                      alignment: Alignment(0.0,-1.0),                                
                                      margin: EdgeInsets.only(
                                        top: 20.0,
                                        right:20.0
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
                  Row(
                      children: <Widget>[
                            Column(
                                children: <Widget>
                                [
                                  Container(      //Photo
                                    margin: EdgeInsets.only(
                                      top: 0.0,
                                      left: width/divisor,
                                    ),
                                    height: 70.0,
                                    width: 70.0, 
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF58F3EC),
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
                            Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 0.0,
                                          left:15.0,                                          
                                        ),
                                           child:  
                                        Text(
                                          "Hola, ${myName[0]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF663300),
                                            fontSize: 25.0,
                                            fontFamily: "Nunito",
                                          ), 
                                        ),
                                       ),
                                      ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          GestureDetector(                           
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ProfileScreen(myData),
                                                    )
                                                  );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 20.0),
                                              child: Icon(Icons.account_circle)
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          GestureDetector(                           
                                            onTap: () {
                                            authBloc = BlocProvider.of<AuthenticationBloc>(context);
                                            authBloc.add(LoggedOut());
                                            },
                                            child: Container(
                                              child: Icon(Icons.exit_to_app)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                             ),
                         ],  
                  ),
                 /* Row(children: <Widget>[                    
                    Expanded(
                      child: 
                        Column(
                          children: <Widget>[
                           Divider(color: Color(0XFFDDF4FF),indent: 20.0, endIndent: 20.0, thickness: 5.0, )
                          ]
                        )
                    ),                    
                  ],
                  ),*/
                ],
             ),
           );               
          }
}