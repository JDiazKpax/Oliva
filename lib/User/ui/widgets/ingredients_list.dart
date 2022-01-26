import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/ingredients_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class IngredientsList extends StatefulWidget{

  IngredientsList();

  @override
  State createState() {    
        return _IngredientsList();
  }
}

class _IngredientsList extends State<IngredientsList> {

  DataBloc dataBloc;

    @override
    void initState() {      
      dataBloc = DataBloc();
      dataBloc.add(BuildIngredientsToday());
      super.initState();  
    }

 @override
 Widget build(BuildContext context) {

  var title = Container(
              margin: EdgeInsets.only(
                  top: 00.0,
                  left: 20.0
                ),
              child:
                Text("Nuestros ingredientes recomendados para hoy",
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
           if(state is IngredientTodayDone){
              return Container(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(child: title),                
                          ],),
                          Container(
                          height: 200.0,
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

 List<Widget> cardsNumber(IngredientTodayDone ingredientToday){
      List<Widget> list = List();
      for(int i=0; i<(ingredientToday.ingredientToday.length); i++){
        list.add(IngredientsCard(ingredientToday.ingredientToday[i].title,ingredientToday.ingredientToday[i].pathImage));
      }
      return list;
  }
}