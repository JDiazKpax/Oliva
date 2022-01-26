import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/profile_stats_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class ProfileStatsList extends StatefulWidget{
 
  ProfileStatsList();
  @override
  State createState() {    
        return _ProfileStatsList();
  }
}

class _ProfileStatsList extends State<ProfileStatsList> {
   
  DataBloc dataBloc;

  @override
  void initState() {
    
    dataBloc = DataBloc();
    dataBloc.add(BuildProfileStats());
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {

  return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is ProfileStatsDone){
             return Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 180.0,
                            child: ListView(
                              padding: EdgeInsets.all(30.0),
                              scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                              children: <Widget>[
                                ProfileStatsCard(number: state.profileStats[0].uploadedRecipes, text: "Recetas\nSubidas"),
                                ProfileStatsCard(number: state.profileStats[0].receivedLikes, text: "Likes\nRecibidos"),
                                ProfileStatsCard(number: state.profileStats[0].favoriteRecipes, text: "Recetas\nFavoritas"),
                                ProfileStatsCard(number: state.profileStats[0].favoriteTips, text: "Tips\nFavoritos")
                              ],
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
}
