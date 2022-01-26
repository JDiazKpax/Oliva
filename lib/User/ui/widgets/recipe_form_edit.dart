import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';

class EditRecipeForm extends StatefulWidget {
   
  final RecipeDone data;

  EditRecipeForm(this.data);

  @override
  State createState() {    
        return _EditRecipeForm();
  }
}

class _EditRecipeForm extends State<EditRecipeForm> {
  DataBloc dataBloc;
  int _counter = 0;
  int _counterTip = 0;
  int _counterProcedure = 0;
  int _counterServe = 0;
  int _counter1;
  int _counter2;
  int _counter3;
  int _counter4;
  String title;
  String category;
  List<String> categorySelect = ["Desayunos", "Almuerzos", "Cenas", "Asiáticos", "Postres", "Europeos", "Saludables", "Rápidos", "Suramericanos", "Veganos", "Vegetarianos", "Del Mundo"];
  List<String> dificultySelect = ["1/5", "2/5", "3/5", "4/5", "5/5"];
  List<String> hoursSelect = ["0h", "1h", "2h", "3h"];
  List<String> minsSelect = ["0m", "10m", "20m", "30m", "40m", "50m"];
  //List<String> unitsSelect = ["Unidad(es)", "Cucharada(s)", "Cucharadita(s)", "Pizca(s)", "Libra(s)", "Miligramo(s)", "Gramo(s)", "Mililitro(s)", "Litro(s)", "Vaso(s)", "Taza(s)", "Cuarto(s)"];
  List<String> unitsSelect = ["Unidad", "Unidades","Cucharada", "Cucharadas", "Cucharadita", "Cucharaditas", "Pizca", "Pizcas", "Libra", "Libras", "Miligramo", "Miligramos", "Gramo", "Gramos", "Mililitro", "Mililitros", "Litro", "Litros", "Vaso", "Vasos", "Taza", "Tazas", "Cuarto", "Cuartos"];
  List<String> _selectedUnits = [];
  String calories;
  String portions;
  String dificulty;
  String hours;
  String myHours;
  String mins;
  String description;
  List<String> tips= List();
  List<String> procedure= List();
  List<String> serve= List();
  List<String> quantity = List();
  List<String> quantityText = List();
  List<String> item = List();
  List<String> quantityTextNew = List();
  String path;
  File myImg;
  String minutes;
  String myQuantityText;
  List<String> itemsNew = List();
  List<String> quantityNew = List();
  String quantityTemp;
  List<String> quantityTemp2;
  String falta ="";

  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
        _selectedUnits.add("Medida");
         super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
  
  return Form(
      key: _formKey,
      child: Column(
        children: _content(context)
      ),
    );
  }

  void _incrementCounter() {
    setState(() { 
      _selectedUnits.add("Medida");    
      _counter++; 
      //_counter2 = widget.data.recipe[0].ingredients.length + _counter; 
    });
  }

  void _incrementTipCounter() {
    setState(() {   
      _counterTip++;       
    });
  }

  void _incrementProcedureCounter() {
    setState(() {   
      _counterProcedure++;       
    });
  }

  void _incrementServeCounter() {
    setState(() {   
      _counterServe++;       
    });
  }

  Widget _titleField(context){
  final mediaWidth = MediaQuery.of(context).size.width / 1.2;
    
    return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Titulo de Receta',
                    maxLines: 1,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Ingresa el titulo de la receta';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      title = value;
                    },
                    initialValue: widget.data.recipe[0].name,
                  ),
          );
  }

  Widget _categoryCaloriesPortions(context){
    final width = MediaQuery.of(context).size.width ;
    double divisor;
    double myLeft; 
    if(width > 420){
      divisor = 3.69;
      myLeft = 47.0;
    }else{
      if(width < 340){
        divisor = 3.75;
        myLeft = 37.0;
      }else{
        if(width < 420 && width >400){
        divisor = 3.72;
        myLeft = 46.0;
      }else{
        divisor = 3.7;
        myLeft = 39.0;
      }
      }
    }

    return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 10.0,left: myLeft),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  width: width/divisor,
                  color: Colors.grey[200],                  
                  child: DropdownButton(
                    value:  category,
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(widget.data.recipe[0].category),
                    items: categorySelect.map((String myCategory) {
                      return DropdownMenuItem<String>(
                        value: myCategory,
                        child: Text(myCategory)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      category = value;
                      setState(() {});
                    },
                  )
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: width/divisor,
                  child:
                    MyTextFormField(
                      hintText: 'Calorías',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Calorías de la Receta';
                          }
                          return null;
                        },
                        maxLines: 1,
                        onSaved: (String value) {
                          calories = value;            
                        },
                        initialValue: widget.data.recipe[0].calories.toString(),
                      ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: width/divisor,
                  child:
                    MyTextFormField(
                      hintText: 'Porciones',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Porciones/Persona';
                          }
                          return null;
                        },
                        maxLines: 1,
                        onSaved: (String value) {
                          portions = value;            
                        },
                        initialValue: widget.data.recipe[0].portions.toString(),
                      ),
                ),
             ],
            ),
          );
  }

  Widget _dificultyHoursMinutes(context){ 
    final width = MediaQuery.of(context).size.width ;

    List<String> temp = widget.data.recipe[0].time.split(" ");
    hours = temp[0];
    minutes = temp[1];

    double divisor;
    double myLeft; 
    if(width > 420){
      divisor = 3.69;
      myLeft = 47.0;
    }else{
      if(width < 340){
        divisor = 3.75;
        myLeft = 37.0;
      }else{
        if(width < 420 && width >400){
        divisor = 3.72;
        myLeft = 46.0;
      }else{
        divisor = 3.7;
        myLeft = 39.0;
      }
      }
    }
      
      return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 10.0,left: myLeft),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  width: width/divisor,
                  color: Colors.grey[200],                  
                  child: DropdownButton(
                    value:  dificulty,
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(widget.data.recipe[0].difficulty),
                    items: dificultySelect.map((String myDificulty) {
                      return DropdownMenuItem<String>(
                        value: myDificulty,
                        child: Text(myDificulty)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      dificulty = value;
                      setState(() {});
                    },
                  )
                ),
               Container(
                  alignment: Alignment.bottomCenter,
                  width: width/divisor,
                  color: Colors.grey[200],                  
                  child: DropdownButton(
                    value: myHours,
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(hours),
                    items: hoursSelect.map((String myHours) {
                      return DropdownMenuItem<String>(
                        value: myHours,
                        child: Text(myHours)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      myHours = value;
                      setState(() {});
                    },
                  )
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: width/divisor,
                  color: Colors.grey[200],                  
                  child: DropdownButton(
                    value:  mins,
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(minutes),
                    items: minsSelect.map((String myMinutes) {
                      return DropdownMenuItem<String>(
                        value: myMinutes,
                        child: Text(myMinutes)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      mins = value;
                      setState(() {});
                    },
                  )
                ),
             ],
            ),
          );
  }

  Widget _description(context){
      final mediaWidth = MediaQuery.of(context).size.width / 1.2;
      return  Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 15.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Breve Descripción (Opcional)',
                    onSaved: (String value) {
                      description = value;
                    },
                    maxLines: 4,
                    initialValue: widget.data.recipe[0].description,
                  ),
          );
  }

  Widget _ingredientsText(String text){
       return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 10.0,left: 46.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0,left: 10.0, bottom: 20.0), 
                      child:Text(text),
                    )
                  ]
                ),
              ]
            )
          );
  }

  Widget _ingredient(context, int i, List<String> itemsNew, List<String> quantityNew, List<String> quantityTextNew){
  final third3MediaWidth = MediaQuery.of(context).size.width / 3;
  final third2MediaWidth = MediaQuery.of(context).size.width / 4.7;
  final width = MediaQuery.of(context).size.width ;
    double divisor;
    double myLeft; 
    double font;
    double font2;
    double font3;
    if(width > 420){
      divisor = 3.69;
      myLeft = 47.0;
      font3 = 17.0;
    }else{
      if(width < 340){
        divisor = 3.5;
        myLeft = 28.0;
        font = 11.0;
        font2 = 13.0;
        font3 = 12.0;
      }else{
        if(width < 420 && width >400){
        divisor = 3.72;
        myLeft = 46.0;
        font3 = 15.0;
        font = 13.0;
      }else{
        divisor = 3.7;
        myLeft = 39.0;
        font = 13.0;
        font3 = 13.0;
      }
      }
    }

   return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: myLeft, bottom: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      width: third2MediaWidth,
                      child:
                        MyTextFormField(
                          hintText: 'Cantidad',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Cantidad del Ingrediente';
                              }
                              return null;
                            },
                            maxLines: 1,
                            onSaved: (String value) {
                              quantity.add(value);            
                            },
                            fontSize: font,
                            initialValue: quantityNew[i],
                          ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: width/divisor,
                      color: Colors.grey[200],                  
                      child: DropdownButton(
                        value:  quantityTextNew[i],
                        underline: Container(height: 3, color: Colors.deepOrange[300]),
                        iconSize: 2,
                        style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: font3,
                                      fontFamily: "Nunito",
                                    ),
                        elevation: 12,
                        dropdownColor: Colors.grey[200],
                        focusColor: Colors.grey[200],
                        hint: Text(quantityTextNew[i]),
                        items: unitsSelect.map((String myUnit) {
                          return DropdownMenuItem<String>(
                            value: myUnit,
                            child: Text(myUnit)
                            );
                        }).toList(), 
                        onChanged: (var value) {
                          quantityTextNew[i] = value;
                          myQuantityText = value;
                          setState(() {});
                        },
                      )
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: third3MediaWidth,
                      child:
                        MyTextFormField(
                          hintText: 'Ingrediente',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Ingrese el Ingrediente';
                              }
                              return null;
                            },
                            maxLines: 1,
                            onSaved: (String value) {
                              item.add(value);            
                            },
                            fontSize: font2,
                            initialValue:  itemsNew[i]
                          ),
                    ),
                ],
                ),
              ]
            )
          );
  }

  Widget _ingredientsPlus(){
    return GestureDetector(                           
                  onTap: () {
                      _incrementCounter();
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 15.0,left: 0.0, bottom: 20.0),
                    width: 120.0,
                    height: 20.0,
                    child: Text("+ Ingredientes",
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 17.0,
                                  fontFamily: "Nunito",
                                  ),
                    ),   
                  ),
          );
  }

  Widget _tips(context, int i){
      final mediaWidth = MediaQuery.of(context).size.width / 1.2;
      String tip;
      if(widget.data.recipe[0].tips.length > i){
        tip = widget.data.recipe[0].tips[i];
      } else{
        tip = "Tip y Clave ${i+1}";
      }
      return  Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Tip y Clave ${i+1}',
                    onSaved: (String value) {
                      tips.add(value);
                    },
                    maxLines: 2,
                    initialValue: tip,
                  ),
          );
  }

  Widget _tipsPlus(){
    return GestureDetector(                           
                  onTap: () {
                      _incrementTipCounter();
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 15.0,left: 0.0, bottom: 20.0),
                    width: 120.0,
                    height: 20.0,
                    child: Text("+ Tips y Claves",
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 17.0,
                                  fontFamily: "Nunito",
                                  ),
                    ),   
                  ),
          );
  }

  Widget _procedure(context, int i){
      final mediaWidth = MediaQuery.of(context).size.width / 1.2;
      String myprocedure;
      if(widget.data.recipe[0].procedure.length > i){
        myprocedure = widget.data.recipe[0].procedure[i];
      } else{
        myprocedure = "Paso ${i+1}";
      }
      return  Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Paso ${i+1}',
                    onSaved: (String value) {
                      procedure.add(value);
                    },
                    maxLines: 2,
                    initialValue: myprocedure
                  ),
                  
          );
  }

  Widget _procedurePlus(){
    return GestureDetector(                           
                  onTap: () {
                      _incrementProcedureCounter();
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 15.0,left: 0.0, bottom: 20.0),
                    width: 120.0,
                    height: 15.0,
                    child: Text("+ Pasos",
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 17.0,
                                  fontFamily: "Nunito",
                                  ),
                    ),   
                  ),
          );
  }

  Widget _serve(context, int i){
      final mediaWidth = MediaQuery.of(context).size.width / 1.2;
      String myserve;
      if(widget.data.recipe[0].serve.length > i){
        myserve = widget.data.recipe[0].serve[i];
      } else{
        myserve = "Tip para Servir ${i+1}";
      }
      return  Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Tip para Servir ${i+1}',
                    onSaved: (String value) {
                      serve.add(value);
                    },
                    maxLines: 2,
                    initialValue: myserve
                  ),
          );
  }

  Widget _servePlus(){
    return GestureDetector(                           
                  onTap: () {
                      _incrementServeCounter();
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 15.0,left: 0.0, bottom: 20.0),
                    width: 120.0,
                    height: 20.0,
                    child: Text("+ Tips para servir",
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 17.0,
                                  fontFamily: "Nunito",
                                  ),
                    ),   
                  ),
          );
  }

  Widget _image(){
    final halfMediaWidth = MediaQuery.of(context).size.width / 2;
    return Container(
      margin: EdgeInsets.only(top: 25.0),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[              
              Container(
                alignment: Alignment.bottomCenter,
                width: halfMediaWidth,
                child:        
              FloatingActionButton(
                backgroundColor: Color(0xFFC6FAFF),
                mini: false,
                onPressed: () async {
                    // File image; //Toma de foto
                    await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 640.0, maxHeight: 480.0)
                        .then((File image) {
                          setState(() {
                          path = "mypath";
                          myImg = image;
                          });
                          }).catchError((onError) => print(onError));                
                    },
                child: Icon(
                  Icons.image,
                  size: 40.0,
                  color: Color(0xff006699),
                ),
                heroTag: null,
              )
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: halfMediaWidth,
                child:        
              FloatingActionButton(
                backgroundColor: Color(0xFFC6FAFF),
                mini: false,
                onPressed: () async {
                    // File image; //Toma de foto
                    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 640.0, maxHeight: 480.0)
                        .then((File image) {
                          setState(() {
                            path = "mypath";
                            myImg = image;
                          });                          
                          }).catchError((onError) => print(onError));                
                    },
                child: Icon(
                  Icons.add_a_photo,
                  size: 40.0,
                  color: Color(0xff006699),
                ),
                heroTag: null,
              ),
              )
            ]
          )
          ]
        )
    );
  } 

  Widget _showImage(){
    if(myImg == null){
      return Container(      
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),         
            height: MediaQuery.of(context).size.width/4,
            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              image: DecorationImage(
                  //fit: BoxFit.fitWidth,
                image: CachedNetworkImageProvider(widget.data.recipe[0].imgUrl)
              ),
            ),      
          );
    }else{
      return Container(      
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),         
            height: MediaQuery.of(context).size.width/4,
            width: MediaQuery.of(context).size.width/2,
           child: Image.file(myImg)     
          );
    }
  } 


  Widget _raisedButton(){
     return Container(
            margin: EdgeInsets.only(top: 25.0, bottom: 40.0),
            child: 
            RaisedButton(
            color: Colors.orangeAccent,
            onPressed: () {
              dataBloc = DataBloc();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();            

              if(category == null){
                category = widget.data.recipe[0].category;
              }
              if(dificulty == null){
                dificulty = widget.data.recipe[0].difficulty;
              }
              if(myHours == null){
                myHours = hours;
              }
              if(mins == null){
                mins = minutes;
              }
              if(quantityText.length == 0){
                quantityText = quantityTextNew;
              }

              dataBloc.add(EditThisRecipe(title,category,calories,portions,dificulty,
              myHours,mins,description,tips,procedure,serve,quantity,quantityTextNew,
              item,myImg,widget.data.recipe[0].uid,widget.data.recipe[0].imgUrl));
               Navigator.pop(context);
              }
               else{
                setState((){
                  falta = "Falta llenar algún campo en el formulario.";
                });                
              }
            },
            child: Text(
              'Guardar Receta',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            )
          );
  }

  Widget _falta(){
    return Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: Text(falta,
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Colors.red,
                                  //fontSize: 17.0,
                                  fontFamily: "Nunito",
                                  ),
                    ),   
    );
  }

  List<Widget> _content(context){

    for(int i=0; i<widget.data.recipe[0].ingredientsFull.length; i++){
        quantityTemp = widget.data.recipe[0].ingredientsFull[i];
        quantityTemp2 = quantityTemp.split("-");
        itemsNew.add(quantityTemp2[0]);
        quantityNew.add(quantityTemp2[1]);
        quantityTextNew.add(quantityTemp2[2]);
    }

    _counter1= widget.data.recipe[0].ingredientsFull.length + _counter;
    _counter2 = widget.data.recipe[0].tips.length + _counterTip;
    _counter3 = widget.data.recipe[0].procedure.length + _counterProcedure;
    _counter4 = widget.data.recipe[0].serve.length + _counterServe;    

    List<Widget> list = List();

    list.add(_titleField(context));
    list.add(_categoryCaloriesPortions(context));
    list.add(_dificultyHoursMinutes(context));
    list.add(_description(context));
    list.add(_ingredientsText("Ingredientes:"));
    for(int i=0; i<_counter1; i++){
      list.add(_ingredient(context,i,itemsNew,quantityNew,quantityTextNew)); 
    }
    list.add(_ingredientsPlus()); 
    list.add(_ingredientsText("Tips y Claves de la Receta:"));
    for(int i=0; i<_counter2; i++){
      list.add(_tips(context,i)); 
    }
    list.add(_tipsPlus());
    list.add(_ingredientsText("Procedimiento de Cocción:"));
    for(int i=0; i<_counter3; i++){
      list.add(_procedure(context,i)); 
    }
    list.add(_procedurePlus());
    list.add(_ingredientsText("Pasos para Servir:"));
    for(int i=0; i<_counter4; i++){
      list.add(_serve(context,i)); 
    }
    list.add(_servePlus());
    list.add(_image());
    list.add(_showImage());
    list.add(_raisedButton());
    list.add(_falta());
     
    return list;     
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final bool isPassword;
  final bool isEmail;
  final int maxLines;
  final double fontSize;
  final String initialValue;
MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.maxLines,
    this.fontSize,
    this.initialValue
  });
@override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
          hintStyle: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: fontSize,
                                      fontFamily: "Nunito",
                                    )
        ),
        maxLines: maxLines,
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  } 
}
