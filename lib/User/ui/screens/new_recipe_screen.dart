import 'package:flutter/material.dart';
import 'package:oliva/User/ui/widgets/recipe_form.dart';
import 'package:oliva/User/ui/widgets/shopping_list_header.dart';

class NewRecipeScreen extends StatefulWidget {
  
  NewRecipeScreen();

  @override
  State createState() {    
        return _NewRecipeScreen();
  }
}

class _NewRecipeScreen extends State<NewRecipeScreen> {
   
    @override
    void initState() {
      super.initState();
    } 
   
   @override
   Widget build(BuildContext context) {
        return Scaffold(
                body:ListView(
                  children: <Widget>[
                    ShoppingListHeader("Subir tu Receta"),
                    RecipeForm(),
                  ]
                )
              );
  }
}