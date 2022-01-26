import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/edit_recipe_screen.dart';

class FloatingButtonEdit extends StatefulWidget{
  //final String recipeName;
  final String uid;
  //FloatingButtonEdit(this.recipeName, this.type);
  FloatingButtonEdit(this.uid);
  
  @override
  State<StatefulWidget> createState() {   
    return _FloatingButtonEdit();
  }
}

class _FloatingButtonEdit extends State<FloatingButtonEdit>{
    
  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
      backgroundColor: Colors.grey,
      mini: true,
      tooltip: "Edit",
      onPressed: (){
          Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) => EditRecipeScreen(widget.uid)                  
                  )
                );
      },
      
      child: Icon(
        Icons.edit 
      ),
      heroTag: null,
    );
  }
}