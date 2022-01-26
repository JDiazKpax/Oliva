import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/fav_tips_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class FavTipsList extends StatefulWidget{

  @override
  State createState() {    
        return _FavTipsList();
  }
}

class _FavTipsList extends State<FavTipsList> {
  int counter = 0; 
  DataBloc dataBloc;

  @override
  void initState() {   
    super.initState();   
  }

 @override
 Widget build(BuildContext context) {
  dataBloc = DataBloc();
  dataBloc.add(BuildFavoriteTips());
  var title = Container(
              margin: EdgeInsets.only(
                  top: 0.0,
                  left: 20.0
                ),
              child:
                Text("Mis Trucos Favoritos",
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
           if(state is FavoriteTipsDone){ 
              return Container(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            title,                
                          ],),
                          Row( 
                            children: <Widget>[
                          //  Container(
                          //   child: 
                         Column(
                                children: _cardContent(context, state)                            
                            ),
                      //    ),                
                          ],),
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
                margin: EdgeInsets.only(top: 30.0,left: 30.0),
                child:
                  Text(
                  "No tienes ningún tip favorito aún.",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF663300),
                      fontSize: 17.0,
                      fontFamily: "Nunito")),
                                          
            ); 
  }

  List<Widget> _cardContent(context, FavoriteTipsDone data){
    List<Widget> list = List();
    int tipsLength;
    if(data.favoriteTips.length != 0){
      tipsLength = data.favoriteTips.length;
      for(int i=0; i<tipsLength; i++){
          list.add(FavTipsCard(data.favoriteTips[i].pathImage, data.favoriteTips[i].title, data.favoriteTips[i].owner, data.favoriteTips[i].uid));
      } 
    }else{
      list.add(_none());
    }
    return list;
  }

}