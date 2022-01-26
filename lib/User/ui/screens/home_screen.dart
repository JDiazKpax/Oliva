import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/blog_list.dart';
import 'package:oliva/User/ui/widgets/categories_list.dart';
import 'package:oliva/User/ui/widgets/home_header.dart';
import 'package:oliva/User/ui/widgets/ingredients_list.dart';
import 'package:oliva/User/ui/widgets/objectives_list.dart';
import 'package:oliva/User/ui/widgets/popular_recipes_list.dart';
import 'package:oliva/User/ui/widgets/quick_recipes_list.dart';
import 'package:oliva/User/ui/widgets/recommended_today.dart';
import 'package:oliva/User/ui/widgets/search.dart';
import 'package:oliva/User/ui/widgets/shopping_list.dart';
import 'package:oliva/User/ui/widgets/social_media.dart';
import 'package:oliva/User/ui/widgets/technique_card.dart';
import 'package:oliva/User/ui/widgets/tips_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';


class HomeScreen extends StatefulWidget {
  
  final DataBrought myData;
  
  
  HomeScreen(this.myData);

  @override
  State createState() {    
        return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
   
    DataBloc dataBloc;
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    RecommendedTodayDone myRecommended;

    @override
    void initState() {
      
      dataBloc = DataBloc();
       if(widget.myData.dataUser[0].onboardSeen != "yes")
       {        
        dataBloc.add(UpdateUserData());
        WidgetsBinding.instance.addPostFrameCallback((_){ 
          Navigator.pushNamed(context,"/onBoard");
        });                        
       }  
       dataBloc.add(BuildRecommendedToday());
       super.initState();  
    }
   
   @override
   Widget build(BuildContext context) {
     return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is RecommendedTodayDone){
            return Scaffold(
              body:ListView(
                children: <Widget>[
                HomeHeader(widget.myData),
                RecommendedToday(state),
                Search(),
                CategoriesList(),
                ObjectivesList(),
                TipsCard(false),
                ShoppingList(),
                QuickRecipesList(),
                BlogList(),
                TechniqueCard(),
                PopularRecipesList(),
                IngredientsList(),
                SocialMedia()
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