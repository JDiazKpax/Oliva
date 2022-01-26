//el orden de consumo es: main->SignInScreen(.dart)->Bloc(bloc_user.dart)->AuthRepository(.dart)->FirebaseAuthAPI(.dart)

import 'package:oliva/widgets/gradient.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  
  final String logoText = "Cocinemos diferente hoy";
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
     return Scaffold(
      body:Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("",null),    //Si paso la altura como null, me lo toma como fullscreen
          Container(
            margin: EdgeInsets.only(
              top: height/5,
              bottom: 40.0,              
            ),
            child: Column(
               children: <Widget>[
                  Container(      //Logo
                    height: 280.0,
                    width: 330.0,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/logo.png"), 
                      ),
                    ),      
                  ),
                  Container(  // Frase App
                     margin: EdgeInsets.only(
                      top: 30.0,
                     ),
                    child: Column(
                     children: <Widget>[  
                      Text(
                        logoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF663300),
                          fontSize: 25.0,
                          fontFamily: "Nunito",
                        ),                        
                      ),
                     ]
                    ),
                  ),
                 ],
               ),
             ),
         ],
       ),
      );
   }
}