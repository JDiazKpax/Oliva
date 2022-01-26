import 'package:flutter/material.dart';
import 'package:oliva/User/ui/widgets/category_list_content.dart';
import 'package:oliva/User/ui/widgets/category_list_header.dart';

class CategoryListScreen extends StatefulWidget {
  
  CategoryListScreen();

  @override
  State createState() {    
        return _CategoryListScreen();
  }
}

class _CategoryListScreen extends State<CategoryListScreen> {
    
    @override
    void initState() {     
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      body:ListView(
        children: <Widget>[ 
         CategoryListHeader(),
         CategoryListContent(),
         ]
      )
     );
  }
}