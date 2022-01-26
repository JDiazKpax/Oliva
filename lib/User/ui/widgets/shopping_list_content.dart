import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/new_ingredient_screen.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class ShoppingListContent extends StatefulWidget{

  ShoppingListContent();

  @override
  State createState() {    
        return _ShoppingListContent();
  }
}

class _ShoppingListContent extends State<ShoppingListContent> {
  DataBloc dataBloc;
  var image;
  var bottomText;
  TextDecoration myDecoration;
  FontStyle myStyle;
  int myColor;
  var eliminado = "no quitar";
  String comprado = "";
  int counter = 0;
  List<bool> checked = List();
  IconData myIcon = Icons.check_box_outline_blank;

  @override
  void initState() {
         super.initState();
  }

  @override
  Widget build (BuildContext context) {
  dataBloc = DataBloc();
  dataBloc.add(BuildShoppingList());

   return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is ShoppingListDone){  
              return Container(
                      margin: EdgeInsets.only(
                        bottom: 40.0
                      ),
                      child:
                        Column(
                          children: _cardContent(context,state),
                        )
              );
            }else{
                    return LoadingIndicator();
            }
          }
      )
    ); 
   } 

  void _removeItem(int index, String ingredient, String quantity, String quantityString, context, String imgUrl) {
    dataBloc = DataBloc();
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildAboutDialog(context),
    ).then((value) {
      if(value == true){
        dataBloc.add(RemoveIngredient(ingredient,quantity,quantityString,imgUrl));
        setState(() {
        });
      }
    });   
  }

  void _buyedItem(String ingredient) {
    dataBloc = DataBloc();
    dataBloc.add(BuyedIngredient(ingredient));
    setState(() {
    });
  }

  void _unbuyedItem(String ingredient) {
    dataBloc = DataBloc();
    dataBloc.add(UnBuyedIngredient(ingredient));
    setState(() {
    });
  }

  Widget _buildAboutDialog(BuildContext context){
    return AlertDialog(
      content: Builder(
        builder: (context){
            double height = MediaQuery.of(context).size.height; 
            return Container(
              height: height/4,
              child:Column(
                children: <Widget>[
                  Icon(Icons.warning),
                  Text(
                "Estás seguro de eliminar el ingrediente de tu lista de compras?",
                textAlign: TextAlign.center,
                style: TextStyle(                                      
                  fontSize: 20.0,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF663300),
                )
              ),
                ],
              ),
            );
        },        
        ),  
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          textColor: Colors.deepOrange, 
          child: Text(
        "Sí",
        textAlign: TextAlign.center,
        style: TextStyle(                                      
          fontSize: 20.0,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w700,
          color: Color(0xFF663300),
        )
      ),
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          textColor: Colors.deepOrange, 
          child:Text(
        "No",
        textAlign: TextAlign.center,
        style: TextStyle(                                      
          fontSize: 20.0,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w700,
          color: Color(0xFF663300),
        )
      ),
        )
      ],
    );
  }

  Widget _card(int index, context, String imgUrl, String item, String quantity, String quantityText,List<List<dynamic>> buyed) {
   double width = MediaQuery.of(context).size.width;
   comprado = "";
   double divisor;
    if(width > 450){
      divisor = 1.9;
    }else{
      if(width < 350){ 
        divisor = 2.8;
      }else{
        divisor = 2;
      }
    }

    if(buyed.length != 0){
      if(buyed[0].length != 0){
        for(int j =0; j<buyed.length; j++){     
          if(item == buyed[0][j]){
            checked[index] = true;
            myDecoration = TextDecoration.lineThrough;
            myStyle = FontStyle.italic;
            myColor = 0xFF999999;
            comprado = "(comprado)";
            myIcon = Icons.check_box;          
            break;
          }else{
            checked[index] = false;
            myDecoration = null;
            myStyle = null;
            myColor = 0xFF663300;
            myIcon = Icons.check_box_outline_blank;

          }
        }
      }else{
        checked[index] = false;
        myDecoration = null;
        myStyle = null;
        myColor = 0xFF663300;
        myIcon = Icons.check_box_outline_blank;
      }
    }else{
    checked[index] = false;
    myDecoration = null;
    myStyle = null;
    myColor = 0xFF663300;
    myIcon = Icons.check_box_outline_blank;
  }

   return Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),    
              child: 
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          margin: EdgeInsets.only(
                            top: 10.0,
                            right: 15.0,
                            left: 20.0
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                                image: CachedNetworkImageProvider(imgUrl)
                            ),
                            shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                            boxShadow: <BoxShadow>[                                     //crea la sombra del container
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 5.0,
                                offset: Offset(0.0, 2.0)
                              ) 
                            ]
                          ),
                      )
                      ]
                    ),                  
                    Container(
                      width: width/divisor,
                      
                    child:
                      Column( 
                        children: <Widget>[
                          Row(
                            children: <Widget>[ 
                                  Flexible(child:                           
                                    Text(
                                    "$item $comprado",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(                                      
                                      fontSize: 20.0,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      decoration: myDecoration, 
                                      fontStyle: myStyle,
                                      color: Color(myColor),
                                    ),
                                    ),
                                  ),
                            ],
                          ),
                          Row(
                          children: <Widget>[                                         
                                Flexible(
                                  child:     
                                    Text(
                                      "$quantity $quantityText",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Nunito",
                                        decoration: myDecoration, 
                                        fontStyle: myStyle,
                                        color: Color(myColor),
                                      ),
                                    ),
                                ),
                            ],
                          ),
                         /* Row(
                          children: <Widget>[                                      
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child:     
                                    Text(
                                      "Nota: Esta es una nota cualquiera del ingrediente quer se debe comprar",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF663300),
                                        fontSize: 16.0,
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                                ),
                            ],
                          ),*/
                        ]
                      ),
                    ),
                    Column(
                      children: <Widget>[
                          Row(
                            children: <Widget>[ 
                              Container(
                                margin: EdgeInsets.only(right:10.0),
                                child:                               
                                InkWell(                           
                                onTap: () {
                                      _removeItem(index,item,quantity,quantityText,context,imgUrl);
                                },
                                child:
                               Icon(Icons.cancel, size: 35, color: Color(0xFF58F3EC),)
                                ),
                              )
                            ]
                          )
                      ],
                    ),
                    Column( 
                      children: <Widget>[
                          Row(
                            children: <Widget>[                               
                                InkWell(                           
                                onTap: () {
                                  if(checked[index] == true){
                                    _unbuyedItem(item);
                                  }else{
                                    _buyedItem(item);
                                  }                                      
                                },
                                child:
                                Icon(myIcon, size: 35, color: Color(0xFF58F3EC),)
                                ),
                            ]
                          )
                      ],
                    )
                  ]
                )
            );
  }

  Widget _cardNew() {
    return Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),    
              child: 
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(                 //Para crear un botón personalizado
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => NewIngredientScreen(),
                                )
                              ).then((value) {
                              setState(() {
                                  counter++;
                              });
                            });
                          },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                        child: 
                        Container(
                          height: 80.0,
                          width: 80.0,
                          margin: EdgeInsets.only(
                            top: 10.0,
                            right: 15.0,
                            left: 20.0
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
                                blurRadius: 5.0,
                                offset: Offset(0.0, 2.0)
                              ) 
                            ]
                          ),
                      ),
                      )
                      ]
                    ),                  
                    Expanded(
                    child:
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[                               
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15.0,
                                  ),
                                  child:                            
                                    Text(
                                    "Nuevo Ingrediente",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 20.0,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    ),
                                ),
                            ],
                          ),
                        ]
                      ),
                    ), 
                  ]
                )
            );
  }

  List<Widget> _cardContent(context, ShoppingListDone listData){
    List<Widget> list = List();  
    List<String> myImgUrl = listData.shoppingList[0].imgUrl;  
    int itemsLength = listData.shoppingList[0].items.length;
    List<List<dynamic>> buyed = listData.shoppingList[0].buyedItems;
    checked = [];

    for(int i=0; i<itemsLength; i++){ 
        checked.add(false);
        list.add(_card(i,context,myImgUrl[i],listData.shoppingList[0].items[i],listData.shoppingList[0].quantity[i],listData.shoppingList[0].quantityText[i],buyed));
    }
    list.add(_cardNew());

    return list;
  }
}