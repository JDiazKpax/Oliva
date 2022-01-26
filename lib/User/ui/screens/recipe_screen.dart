import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/recipe_final_photo.dart';
import 'package:oliva/User/ui/widgets/recipe_header.dart';
import 'package:oliva/User/ui/widgets/recipe_ingredients_card.dart';
import 'package:oliva/User/ui/widgets/recipe_stats_list.dart';
import 'package:oliva/User/ui/widgets/recipe_tips_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';
import 'package:screenshot/screenshot.dart';

class RecipeScreen extends StatefulWidget {
  
  final String uidB;
  RecipeScreen(this.uidB);

  @override
  State createState() {    
        return _RecipeScreen();
  }
}

class _RecipeScreen extends State<RecipeScreen> {
   
    DataBloc dataBloc;
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    ScreenshotController screenshotController = ScreenshotController();
    
    @override
    void initState() {
      dataBloc = DataBloc();
      dataBloc.add(BuildRecipe(widget.uidB));
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
              body:Screenshot(
              controller: screenshotController,
              child:
              ListView(
                children: <Widget>[
                  
                RecipeHeader(state),
                RecipeStatsList(state),
                RecipeIngredientsCard(state,screenshotController),
                RecipeTipsCard(state, "tips"),
                RecipeTipsCard(state, "procedure"),
                RecipeTipsCard(state, "serve"),
                RecipeFinalPhoto(state), 
              //  SocialMediaRecipe()
                ]
              )
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