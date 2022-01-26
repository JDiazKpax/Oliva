import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/new_recipe_screen.dart';
import 'package:oliva/User/ui/widgets/uploaded_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class UploadedRecipesList extends StatefulWidget{

  UploadedRecipesList();
  @override
  State createState() {    
        return _UploadedRecipesList();
  }
}

class _UploadedRecipesList extends State<UploadedRecipesList> {
  int counter = 0; 
  DataBloc dataBloc;

  @override
  void initState() {   
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
  dataBloc = DataBloc();
  dataBloc.add(BuildUploadedRecipes());
  var title = Container(
              margin: EdgeInsets.only(
                  top: 30.0,
                  left: 20.0
                ),
              child:
                Text("Mis Recetas Subidas",
                textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF663300),
                    fontSize: 20.0,
                    fontFamily: "Nunito")),
              );         
   
   return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is UploadedRecipesDone){            
            return Container(
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          title,                
                        ],),
                        Container(
                        height: 300.0,
                        child: ListView(
                          padding: EdgeInsets.all(30.0),
                          scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                          children: _cardContent(context, state)
                        ),
                        )
                      ]
                    )
            );
            }else{
              return LoadingIndicator();
            }
          }
      )
     );
  }

  Widget buildInitial() {
    return InkWell(                 //Para crear un botón personalizado
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewRecipeScreen(),
                      )
                    ).then((value) {
                      Timer(const Duration(milliseconds: 1800), (){
                      setState(() {
                          counter++;
                      });
                    });
                    });
                },              //dado que las variables están en la clase superior, se accede a ellas con widget.
               child:
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          height: 180.0,
                          width: 200.0,
                          margin: EdgeInsets.only(
                            left: 20.0,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                              image: AssetImage("assets/img/plus.jpg")
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                            shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                            boxShadow: <BoxShadow>[                                     //crea la sombra del container
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 7.0)
                              ) 
                            ]
                          ),
                      ),
                      
                    ]
                  ),
                  Row(
                    children: <Widget>[                      
                                Container(
                                margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0
                                ),
                                width: 200.0,
                                child:                            
                                  Text(
                                    "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 18.0,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                              ),
                        ]
                  ),
                ]
              )
              );
  }
 
  List<Widget> _cardContent(context, UploadedRecipesDone data){
    List<Widget> list = List();
    int recipesLength;
    list.add(buildInitial());
    recipesLength = data.uploadedRecipes.length;
    for(int i=0; i<recipesLength; i++){
          list.add(UploadedCard(data.uploadedRecipes[i].recipeData["name"],data.uploadedRecipes[i].recipeData["imgUrl"],180.0,200.0,0,true,data.uploadedRecipes[i].recipeData["uid"],));
    } 
    return list;
  }
}