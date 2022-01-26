import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';

class FloatingActionButtonGreen extends StatefulWidget{
  final String recipeName;
  final String type;
  FloatingActionButtonGreen(this.recipeName, this.type);
  
  @override
  State<StatefulWidget> createState() {   
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen>{
  bool _pressed = false;
  DataBloc dataBloc;
  void onPressedFav(){
    setState(() {
      _pressed = !this._pressed;
    });
    
    dataBloc = DataBloc();
    if(widget.type == "recipes"){
        dataBloc.add(LikeRecipe(widget.recipeName));
    }
    if(widget.type == "tips"){
        dataBloc.add(LikeTips(widget.recipeName));
    }   
    
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text("Agregado a tus favoritos")
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: onPressedFav,     //metodo creado arriba
      child: Icon(
        _pressed == true ? Icons.favorite : Icons.favorite_border 
      ),
      heroTag: null,
    );
  }
}