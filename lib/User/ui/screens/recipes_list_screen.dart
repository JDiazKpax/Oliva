import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/ui/widgets/list_detail_content.dart';
import 'package:oliva/User/ui/widgets/list_detail_header.dart';
import 'package:oliva/User/model/data_state.dart';

class RecipesListScreen extends StatefulWidget {
  
  final CategoryDone categoryData;
  RecipesListScreen(this.categoryData);

  @override
  State createState() {    
        return _RecipesListScreen();
  }
}

class _RecipesListScreen extends State<RecipesListScreen> {
   
    // ignore: close_sinks
    DataBloc dataBloc;
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    
    @override
    void initState() {
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      body:ListView(
        children: <Widget>[
         ListDetailHeader(widget.categoryData,"recipes"),
         ListDetailContent(widget.categoryData,"recipes"),
         ]
      )
     );
  }
}