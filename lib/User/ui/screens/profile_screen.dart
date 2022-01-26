import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/fav_recipes_list.dart';
import 'package:oliva/User/ui/widgets/fav_tips_list.dart';
import 'package:oliva/User/ui/widgets/inspiration_list.dart';
import 'package:oliva/User/ui/widgets/profile_header.dart';
import 'package:oliva/User/ui/widgets/profile_stats_list.dart';
import 'package:oliva/User/ui/widgets/social_media.dart';
import 'package:oliva/User/ui/widgets/uploaded_recipes_list.dart';


class ProfileScreen extends StatefulWidget {
  
  final DataBrought myData;
  
  ProfileScreen(this.myData);

  @override
  State createState() {    
        return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
   
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
         ProfileHeader(widget.myData),
         ProfileStatsList(),
         UploadedRecipesList(),
         FavRecipesList(),
         FavTipsList(),
         InspirationList(),
         SocialMedia()
        ]
      )
     );
  }
}