import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/search_screen.dart';

class Search extends StatelessWidget{

  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     return  Container(              
             margin: EdgeInsets.only(
                top: 30.0,
                bottom:20.0
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
                            Text("¿Qué quieres cocinar?",
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
                           Container(
                            margin: EdgeInsets.only(
                              top: 20.0,
                              left:30.0,
                              right: 30.0,
                            ),
                            child: TextField(
                              onSubmitted: (value) {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SearchScreen(value),
                                    )
                                  ); 
                             },
                                    
                              controller: editingController,                              
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0XFFDDF4FF),
                                  focusColor: Color(0XFFDDF4FF),
                                  labelText: "Buscar",
                                  hintText: "Buscar",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
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