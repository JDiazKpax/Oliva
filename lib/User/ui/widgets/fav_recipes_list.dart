import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/home_screen_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class FavRecipesList extends StatefulWidget{

  @override
  State createState() {    
        return _FavRecipesList();
  }
}

class _FavRecipesList extends State<FavRecipesList> {
  int counter = 0;
  double height = 300.0; 
  DataBloc dataBloc;

  @override
  void initState() {   
    super.initState();   
  }
  
  @override
  Widget build(BuildContext context) {
  dataBloc = DataBloc();
  dataBloc.add(BuildFavoriteRecipes());

  var title = Container(
              margin: EdgeInsets.only(
                  top: 0.0,
                  left: 20.0
                ),
              child:
                Text("Mis Recetas Favoritas",
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
           if(state is FavoriteRecipesDone){ 
             if(state.favoriteRecipes.length == 0){
              height = 100.0;
             }    
              return Container(
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[ 
                        title,                
                      ],),
                      Container( 
                      height: height,
                      child: 
                      ListView(
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

    Widget _none(){
    return  Container(
             //   margin: EdgeInsets.only(left: 30.0),
                child:
                  Text(
                  "No tienes ninguna receta favorita aún.",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF663300),
                      fontSize: 17.0,
                      fontFamily: "Nunito")),
                                          
            );
  }

  List<Widget> _cardContent(context, FavoriteRecipesDone data){
    List<Widget> list = List();
    int recipesLength;
    if(data.favoriteRecipes.length != 0)
    {
      recipesLength = data.favoriteRecipes.length;
      for(int i=0; i<recipesLength; i++){
            list.add(HomeScreenCard(data.favoriteRecipes[i].recipeData["name"],data.favoriteRecipes[i].recipeData["imgUrl"],"popular",180.0,200.0,0,true,data.favoriteRecipes[i].recipeData["uid"],));
      } 
    }else{
      list.add(_none());
    }
    return list;
  }
}