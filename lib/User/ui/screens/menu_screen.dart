import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/model/auth_events.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/category_list_screen.dart';
import 'package:oliva/User/ui/screens/profile_screen.dart';
import 'package:oliva/User/ui/screens/shopping_list_screen.dart';
import 'package:oliva/User/ui/screens/tip_list_screen.dart';

class MenuScreen extends StatelessWidget{

  final DataBrought myData;
  MenuScreen(this.myData);

  @override
  Widget build (BuildContext context) {
  
    
   var close = Container(
                  margin: EdgeInsets.only(
                          top: 10.0,
                  ),
                  child: 
                    Column(
                      children: <Widget>[                              
                          Row(
                            children: <Widget>[
                              Expanded(
                              child:
                                InkWell(                 //Para crear un botón personalizado
                                  onTap: () {
                                    Navigator.pop(context);
                                  },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                                  child:
                                    Container(
                                        margin: EdgeInsets.only(
                                          top: 17.0,
                                          left:0.0
                                        ),
                                        alignment: Alignment.bottomCenter,
                                        child:
                                          Text("X",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                            color: Color(0xFF663300),
                                            fontSize: 30.0,
                                            fontFamily: "Nunito"
                                            )
                                          )
                                      )
                                )
                             )
                          ]
                        )
                      ]
                    )
                );
    
    
    
    return Scaffold(
      body:ListView(
        children: <Widget>[
          close,
          _card(context, "Recetas", 0xFFC6FAFF),
         // _card(context, "Buscador", 0xFF58F3EC),
          _card(context, "Mi Perfil", 0xFF58F3EC),
          _card(context, "Blogs", 0xFFC6FAFF),
          _card(context, "Técnicas y Trucos", 0xFF58F3EC),
          _card(context, "Mi Lista de compras", 0xFFC6FAFF),
          _card(context, "Salir de Oliva", 0xFF58F3EC),
         ]
      )
     );
      
   
  }

  Widget _card(BuildContext context, String text, int color) {
    // ignore: close_sinks
    AuthenticationBloc authBloc;
          return Container(                   
             child:
               Column(
                  children: <Widget>[                              
                      Row(
                        children: <Widget>[
                          Expanded(
                          child:
                           InkWell(                 //Para crear un botón personalizado
                            onTap: () {
                              if(text=="Salir de Oliva"){
                                        Navigator.pop(context);
                                        authBloc = BlocProvider.of<AuthenticationBloc>(context);
                                        authBloc.add(LoggedOut());
                                                                                                                       
                               }else{  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(                                  
                                        builder: (BuildContext context) {
                                          if(text=="Recetas"){
                                            return CategoryListScreen();                                      
                                          }
                                          if(text=="Buscador"){
                                            return CategoryListScreen();                                      
                                          }
                                          if(text=="Mi Perfil"){
                                            return ProfileScreen(myData);                                      
                                          }
                                          if(text=="Blogs"){
                                            return TipListScreen("blogs");                                      
                                          }
                                          if(text=="Técnicas y Trucos"){
                                            return TipListScreen("tips");                                      
                                          }
                                          if(text=="Mi Lista de compras"){
                                            return ShoppingListScreen();                                      
                                          }                                      
                                          else{
                                            return CircularProgressIndicator();
                                          }                                  
                                        }                                               
                                      
                                      )
                                );
                               }
                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                            child:
                              Stack(
                                children: <Widget> [
                                    Container(
                                      height: 100.0,
                                      width: MediaQuery.of(context).size.width,                                
                                      decoration: BoxDecoration(
                                        color: Color(color)
                                      ),      
                                    ),
                                    Container(
                                      height: 100.0,
                                      alignment: Alignment.center,
                                      child:
                                        Text(text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                          color: Color(0xFF663300),
                                          fontSize: 22.0,
                                          fontFamily: "Nunito"
                                          )
                                        )
                                    )
                                ]
                              )
                           ),
                          ),
                        ],
                       ),
                       
                      ],
                    ), 
           );
  }    
}