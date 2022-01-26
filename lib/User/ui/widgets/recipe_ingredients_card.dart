import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/button_click.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share_plugin/social_share_plugin.dart';

class RecipeIngredientsCard extends StatefulWidget{
  
  final RecipeDone recipe;
  final ScreenshotController screenshotController;

  RecipeIngredientsCard(this.recipe,this.screenshotController);
  
  @override
  State createState() {    
        return _RecipeIngredientsCard();
  }
}

class _RecipeIngredientsCard extends State<RecipeIngredientsCard> {
  int _counterInitial;
  int _myCounter;
  int _counter = 1;
  double divisor;
  List<dynamic> myQuantity = List<dynamic>();
  List<dynamic> myQuantityText = List<dynamic>();
  List<dynamic> myIngredientsText = List<dynamic>();
  List<dynamic> myQuantityAmount = List<dynamic>();
  List<dynamic> addText = new List<dynamic>();
  DataBloc dataBloc;

  @override
  void initState() {
    super.initState();
        _counterInitial = widget.recipe.recipe[0].portions;
        _myCounter = widget.recipe.recipe[0].portions;
  }

  @override
  Widget build (BuildContext context) {

  var cardTotal = Container(
                    margin: EdgeInsets.only(
                      top: 15.0,
                      left: 10.0               
                    ),
                    child:
                    Column(
                      children: _cardContent(context)
                    )
                );
  
 return Container(              
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
                left: 12.0,
                right: 15.0,
                ),
               decoration: BoxDecoration(               
                color: Color(0XFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                boxShadow: <BoxShadow>[                                     //crea la sombra del container
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 2.0)
                  ) 
                ]
              ),
              child:
              Column(
                children: <Widget>[
                    cardTotal
                ],
              )
            );

  }

  void _incrementCounter() {
    myQuantity = [];
    var temp1;
    var temp2;
    myQuantity.length = widget.recipe.recipe[0].ingredientsFull.length;
    String quantityTemp;
    List<String> quantityTemp2;
    setState(() {
      _counter++;
      _counterInitial = _counterInitial + widget.recipe.recipe[0].portions;
      for(int i = 0; i < widget.recipe.recipe[0].ingredientsFull.length; i++){
        quantityTemp = widget.recipe.recipe[0].ingredientsFull[i];
        quantityTemp2 = quantityTemp.split("-");
        temp2 = double.parse(quantityTemp2[1]) * _counter;
        temp1 = temp2.toString();
        temp1 = temp1.split(".");
        if(temp1[1] == "0"){
          myQuantity[i] = int.parse(temp1[0]);
        }else{
          myQuantity[i] = temp2;
        }
        
      }
    });
  }

  void _decrementCounter() {
    String quantityTemp;
    var temp1;
    var temp2;
    List<String> quantityTemp2;
    setState(() {
      _counter--;
      _counterInitial = _counterInitial - widget.recipe.recipe[0].portions;
      if(_counter > 0){
        for(int i = 0; i < widget.recipe.recipe[0].ingredientsFull.length; i++){
         quantityTemp = widget.recipe.recipe[0].ingredientsFull[i];
          quantityTemp2 = quantityTemp.split("-");
          temp2 = myQuantity[i] - double.parse(quantityTemp2[1]);
          temp1 = temp2.toString();
          temp1 = temp1.split(".");
          if(temp1[1] == "0"){
          myQuantity[i] = int.parse(temp1[0]);
          }else{
            myQuantity[i] = temp2;
          }
        }
      }else{
        _counter = 1;
        _counterInitial = _myCounter;
        for(int i = 0; i < widget.recipe.recipe[0].ingredientsFull.length; i++){
           quantityTemp = widget.recipe.recipe[0].ingredientsFull[i];
            quantityTemp2 = quantityTemp.split("-");
            temp2 =double.parse(quantityTemp2[1]);
            temp1 = temp2.toString();
            temp1 = temp1.split(".");
            if(temp1[1] == "0"){
            myQuantity[i] = int.parse(temp1[0]);
            }else{
              myQuantity[i] = temp2;
            }
          }
      }
    });
  }

  void _addItem(int i, String ingredient, String quantity, String quantityString) {
    dataBloc = DataBloc();
    if(quantityString == ""){
      quantityString = "Unds.";
    }
    dataBloc.add(AddIngredient(ingredient,quantity,quantityString,null));
    setState(() {
      addText[i] = Icons.check_box;
    });
  }

  Widget headerRow1() {
    final width = MediaQuery.of(context).size.width;

    if(width > 420){
      divisor = 30.0;
    }else{
      if(width < 340){
        divisor = 10.0;
      }else{
        divisor = 15.0;
      }
    }
    return Row(
            children: <Widget>[                 
                  Column(
                    children: <Widget>[                          
                      Container(
                        child:                            
                          Text(
                            "Porciones: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 15.0,
                              fontFamily: "Nunito",
                            ),
                          ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[                          
                      InkWell(                           
                              onTap: () {
                                _decrementCounter();
                              },
                              child: Icon(Icons.arrow_drop_down, size: 35)
                            ), 
                    ],
                  ),
                   Column(
                    children: <Widget>[                          
                      Container(
                        child:                            
                          Text(
                            "$_counterInitial",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 17.0,
                              fontFamily: "Nunito",
                            ),
                          ),
                      ),
                    ],
                  ),
                   Column(
                    children: <Widget>[                          
                      InkWell(                           
                              onTap: () {
                                _incrementCounter();
                              },
                              child: Icon(Icons.arrow_drop_up, size: 35)
                            ),
                    ],
                  ),
                  Container(  // Sign In Icons
        margin: EdgeInsets.only(
          top: 20.0,
          bottom: 20.0
        ),
        child: Row(
        children: <Widget>[ 
          ButtonClick(            
            onPressed: () async {
              if(widget.recipe.recipe[0].description.length>159){
                    await SocialSharePlugin.shareToTwitterLink(text: "Encontré esta receta genial en OlivaApp: ${widget.recipe.recipe[0].name}, ${widget.recipe.recipe[0].description.substring(0,160)}...", url: 'https://olivacocina.page.link/R6GT');
              }
              else{
                    await SocialSharePlugin.shareToTwitterLink(text: "Encontré esta receta genial en OlivaApp: ${widget.recipe.recipe[0].name}, ${widget.recipe.recipe[0].description.substring(0,widget.recipe.recipe[0].description.length)}...", url: 'https://olivacocina.page.link/R6GT');
              }      
                  
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/twitter2.png",
            buttonLeft: (width/2)-150.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),
            ButtonClick(
            onPressed: () async {
              File file = await widget.screenshotController.capture(pixelRatio: 2.0);
              await SocialSharePlugin.shareToFeedFacebook(path: file.path);
             // await SocialSharePlugin.shareToFeedFacebookLink(quote: 'Yo recomiendo Oliva, una app genial para cocinar de manera diferente, gestionar fácilmente una lista de compras, descubrir recetas novedosas y saludables y subir mi propias creaciones.', url: 'https://bitbrant.com');
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/facebook2.png",
            buttonLeft: divisor,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ), 
             ButtonClick(
            onPressed: () async {
              File file = await widget.screenshotController.capture(pixelRatio: 2.0);
                    await SocialSharePlugin.shareToFeedInstagram(path: file.path);                
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/instagram2.png",
            buttonLeft: divisor,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),                              
          ] 
        )
      ),
            ],
          );
  }

  Widget headerRow2() {    
    return Row(
            children: <Widget>[                                         
                Expanded(
                  child:
                  Container(
                    child:     
                      Text(
                        "\nIngredientes:\n",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF663300),
                          fontSize: 15.0,
                          fontFamily: "Nunito",
                        ),
                      ),
                  ),
                ),
              ],
            );
  }

  Widget headerRow3(context) {
    double width = MediaQuery.of(context).size.width;
    double systemSize = MediaQuery.of(context).textScaleFactor;
    double font;

    if(width > 400){
      font = 18.0;
    }else{
      if(width < 340){
        font = 13.0;
      }else{
        font = 15.0;
      }
    }

    
  if(systemSize > 1){
      font = 11.0;
    }
  if(systemSize > 1.4){
      font = 10.0;
    }
   
    return Container(
              margin: EdgeInsets.only(
                bottom: 15.0,
              ),
              child:
                Row(
                children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: width/6,                               
                            child:     
                              Text(
                                "Cantidad",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: font,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                          ),
                        ]
                      ),
                      Expanded(
                      child:
                      Column(
                        children: <Widget>[
                          Container(
                            width: width/2,
                            child:     
                              Text(
                                "Ingrediente",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: font,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                          ),
                        ]
                      ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: width/6,
                            child:     
                              Text(
                                "Agregar a Compras",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: font,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                          ),
                        ]
                      ),
                  ],
                ),
              );
  }

  Widget headerRow4(context, int i) {
    double width = MediaQuery.of(context).size.width;
    double systemSize = MediaQuery.of(context).textScaleFactor;
    double font;
    double font2;
    var temp1;
    var temp2;
    var temp3;
    if(width > 400){
      font = 16.0;
      font2 = 14.0;
    }else{
      if(width < 340){
        font = 13.0;
        font2 = 11.0;
      }else{
        font = 14.0;
        font2 = 12.0;
      }
    }

    if(systemSize > 1){
      font = 11.0;
      font2 = 9.0;
    }
    if(systemSize > 1.4){
      font = 10.0;
      font2 = 9.0;
    }
    String quantityTemp;
    List<String> quantityTemp2 = [];
    myQuantityText = [];
    myIngredientsText = [];
    myQuantityAmount = [];
    for(int j=0; j<widget.recipe.recipe[0].ingredientsFull.length; j++){
      quantityTemp = widget.recipe.recipe[0].ingredientsFull[j];
      quantityTemp2 = quantityTemp.split("-");
      myQuantityAmount.add(quantityTemp2[1]);
      myIngredientsText.add(quantityTemp2[0]);
      myQuantityText.add(quantityTemp2[2]);
    }
    
    if(myQuantity.length == 0){
        myQuantity = myQuantityAmount;
    }
    temp3 = myQuantity[i];
    temp2 = myQuantity[i];
    temp1 = temp2.toString();
    temp1 = temp1.split(".");
    if(temp1.length > 1){
      switch(temp1[0]){
        case "0": temp2 = "1/2"; break;
      }
    }  
  
    return Container(
            margin: EdgeInsets.only( 
              bottom: 15.0,
            ),
            child:
              Row(
              children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: width/6,                               
                          child:     
                            Text(
                              "$temp2 ${myQuantityText[i]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF663300),
                                fontSize: font2,
                                fontFamily: "Nunito",
                              ),
                            ),
                        ),
                      ]
                    ),
                    Expanded(
                    child:
                    Column(
                      children: <Widget>[
                        Container(
                          width: width/2,
                          child:     
                            Text(
                              myIngredientsText[i].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF663300),
                                fontSize: font,
                                fontFamily: "Nunito",
                              ),
                            ),
                        ),
                      ]
                    ),
                    ),
                    Column( 
                      children: <Widget>[
                        InkWell(                           
                         onTap: () {
                              _addItem(i,myIngredientsText[i],temp3.toString(),myQuantityText[i]);
                         },
                         child:                       
                         Container(
                        margin: EdgeInsets.only(right:15.0),
                          child: Icon(addText[i])
                        ),
                        ),
                      ]
                    ),
                ],
              ),
            );
  }

  List<Widget> _cardContent(context){
    List<Widget> list = List();
    list.add(headerRow1());
    list.add(headerRow2());
    list.add(headerRow3(context));

    for(int i = 0; i < widget.recipe.recipe[0].ingredients.length; i++){
      addText.add(Icons.check_box_outline_blank);
      list.add(headerRow4(context, i));            
    }
    return list;
  }
}