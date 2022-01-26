import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/list_detail_content.dart';
import 'package:oliva/User/ui/widgets/list_detail_header.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class ObjectivesListScreen extends StatefulWidget {
  
  final String myCategory;
  final int myCalories;
  final String type;
  ObjectivesListScreen(this.myCategory, this.myCalories, this.type);

  @override
  State createState() {    
        return _ObjectivesListScreen();
  }
}

class _ObjectivesListScreen extends State<ObjectivesListScreen> {
   
    DataBloc dataBloc;
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    
    @override
    void initState() {
      dataBloc = DataBloc();
      if(widget.type == "objective"){      
        dataBloc.add(BuildObjective(widget.myCategory, widget.myCalories));
      }
      if(widget.type == "quick"){      
        dataBloc.add(BuildQuickRecipes(widget.myCategory, widget.myCalories));
      }
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
     return BlocProvider<DataBloc>(
      create: (context) => dataBloc, 
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is CategoryDone){     
              return Scaffold(
                body:ListView(
                  children: <Widget>[
                    ListDetailHeader(state,"recipes"),
                    ListDetailContent(state,"recipes"),
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