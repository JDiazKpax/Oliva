import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/new_ingredient_screen.dart';
import 'package:oliva/User/ui/screens/shopping_list_screen.dart';
import 'package:oliva/User/ui/widgets/shopping_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class ShoppingList extends StatefulWidget{

  ShoppingList();

  @override
  State createState() {    
        return _ShoppingList();
  }
}

class _ShoppingList extends State<ShoppingList> {
  int counter = 0;
  DataBloc dataBloc;

    @override
    void initState() {      
      super.initState();  
    }

 @override
 Widget build(BuildContext context) {
   dataBloc = DataBloc();
   dataBloc.add(BuildShoppingList());
  var title = Container( 
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Tu Lista de Compras:",
                        textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF663300),
                            fontSize: 20.0,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(                 //Para crear un botón personalizado
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ShoppingListScreen(),
                                )
                              ).then((value) {
                                setState(() {
                                    counter++;
                                });
                              });
                          },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                          child: Icon(Icons.open_in_new)
                        )
                      ]
                    )
                  ]
                )
            );
     
              
  return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is ShoppingListDone){  
            return Container(
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          title,                
                        ],),
                        Container(
                        height: 220.0,
                        child: ListView(
                          padding: EdgeInsets.all(30.0),
                          scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                          children: cardsNumber(state),
                        ),
                        ),
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
 
 List<Widget> cardsNumber(ShoppingListDone shoppingList){
      List<Widget> list = List();
     // List<List<dynamic>> myImgUrl = shoppingList.shoppingList[0].imgUrl;
      List<String> myImgUrl = shoppingList.shoppingList[0].imgUrl;
      List<List<dynamic>> buyed = shoppingList.shoppingList[0].buyedItems;
      list.add(buildInitial());
      if(shoppingList.shoppingList[0].items != null){
        for(int i=0; i<(shoppingList.shoppingList[0].items.length); i++){
          list.add(ShoppingCard(myImgUrl[i],shoppingList.shoppingList[0].items[i],shoppingList.shoppingList[0].quantity[i],shoppingList.shoppingList[0].quantityText[i],buyed));
        }
      }
      return list;
  }

  Widget buildInitial() {     
    return InkWell(                 //Para crear un botón personalizado
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewIngredientScreen(),
                      )
                    ).then((value) {
                      Timer(const Duration(milliseconds: 1800), (){
                      setState(() {
                          counter++;
                      });
                    });
                    });
                },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                child:  
                  Container(
                  height: 250.0,
                  width: 200.0,
                  margin: EdgeInsets.only(
                    left: 20.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,                //que quede en todo el container
                      image: AssetImage("assets/img/plus.jpg"), 
                    ),
                    shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                    boxShadow: <BoxShadow>[                                     //crea la sombra del container
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 7.0)
                      ) 
                    ]
                  ),
                  ),
              );
  }
}
