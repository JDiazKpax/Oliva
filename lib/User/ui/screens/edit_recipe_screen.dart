import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/recipe_form_edit.dart';
import 'package:oliva/User/ui/widgets/shopping_list_header.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class EditRecipeScreen extends StatefulWidget {
  
  final String uid;
  EditRecipeScreen(this.uid);

  @override
  State createState() {    
        return _EditRecipeScreen();
  }
}

class _EditRecipeScreen extends State<EditRecipeScreen> {
   
    DataBloc dataBloc;
    @override
    void initState() {
      dataBloc = DataBloc();
      dataBloc.add(BuildRecipe(widget.uid)); 
      super.initState(); 
    } 
   
   @override
   Widget build(BuildContext context) {
     return BlocProvider<DataBloc>(
      create: (context) => dataBloc, 
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is RecipeDone){
              return Scaffold(
                      body:ListView(
                        children: <Widget>[
                          ShoppingListHeader("Editar tu Receta"),
                          EditRecipeForm(state),
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