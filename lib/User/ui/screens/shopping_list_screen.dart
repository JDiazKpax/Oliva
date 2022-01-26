import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/ui/widgets/shopping_list_content.dart';
import 'package:oliva/User/ui/widgets/shopping_list_header.dart';

class ShoppingListScreen extends StatefulWidget {
  
  ShoppingListScreen();

  @override
  State createState() {    
        return _ShoppingListScreen();
  }
}

class _ShoppingListScreen extends State<ShoppingListScreen> {
   
    DataBloc dataBloc;
    
    @override
    void initState() {
      dataBloc = DataBloc();
      dataBloc.add(BuildShoppingList());
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
              return Scaffold(
                body:ListView(
                  children: <Widget>[
                  ShoppingListHeader("Tu Lista de Compras"),
                  ShoppingListContent(),
                  ]
                )
              );
   } 
}