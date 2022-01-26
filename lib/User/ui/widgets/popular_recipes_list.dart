import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/ui/widgets/home_screen_card.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class PopularRecipesList extends StatefulWidget{

  PopularRecipesList();
  
  @override
  State createState() {    
        return _PopularRecipesList();
  }
}

class _PopularRecipesList extends State<PopularRecipesList> {

  DataBloc dataBloc;

    @override
    void initState() {      
      dataBloc = DataBloc();
      dataBloc.add(BuildPopularToday());
      super.initState();  
    }

 @override
 Widget build(BuildContext context) {

  var title = Container(
                  margin: EdgeInsets.only(
                      top: 30.0,
                      left: 20.0
                    ),
                  child:
                    Text("Recetas más populares",
                    textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF663300),
                        fontSize: 20.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700)),
              );         
              
  return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is PopularTodayDone){
              return Container(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            title,                
                          ],),
                          Container(
                          height: 320.0,
                          child: ListView(
                            padding: EdgeInsets.all(30.0),
                            scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                            children: cardsNumber(state)                              
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

  List<Widget> cardsNumber(PopularTodayDone popularToday){
      List<Widget> list = List();
      for(int i=1; i<((popularToday.popularToday[0].recipeData.length/3)+1); i++){
        list.add(HomeScreenCard(popularToday.popularToday[0].recipeData["recipeName$i"],popularToday.popularToday[0].recipeData["photoUrl$i"],"popular",200.0,200.0,0,true,popularToday.popularToday[0].recipeData["uid$i"]));
      }
      return list;
  } 
}