import 'package:flutter/material.dart';
import 'package:oliva/User/ui/widgets/ingredient_form.dart';
import 'package:oliva/User/ui/widgets/shopping_list_header.dart';

class NewIngredientScreen extends StatefulWidget {
  
  NewIngredientScreen();

  @override
  State createState() {    
        return _NewIngredientScreen();
  }
}

class _NewIngredientScreen extends State<NewIngredientScreen> {
   
    @override
    void initState() {
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
        return Scaffold(
                body:ListView(
                  children: <Widget>[
                    ShoppingListHeader("Agregar Ingrediente a la Lista de Compras"),
                    IngredientForm(),
                  ]
                )
              );
          
  }
}