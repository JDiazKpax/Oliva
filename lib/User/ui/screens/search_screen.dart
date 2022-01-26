import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/ui/widgets/search_content.dart';
import 'package:oliva/User/ui/widgets/shopping_list_header.dart';

class SearchScreen extends StatefulWidget {
  
  final String textSearch; 
  SearchScreen(this.textSearch);

  @override
  State createState() {    
        return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
   
    // ignore: close_sinks
    DataBloc dataBloc;
    
    @override
    void initState() {
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
              return Scaffold(
                body:ListView(
                  children: <Widget>[
                  ShoppingListHeader("Resultados"),
                  SearchContent(widget.textSearch),
                  ]
                )
              );
   } 
}