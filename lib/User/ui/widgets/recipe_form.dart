import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';

class RecipeForm extends StatefulWidget {
   
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  RecipeForm({
    this.hintText,  
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });
  @override
  State createState() {    
        return _RecipeForm();
  }
}

class _RecipeForm extends State<RecipeForm> {
  DataBloc dataBloc;
  int _counter = 1;
  int _counterTip = 1;
  int _counterProcedure = 1;
  int _counterServe = 1;
  String title;
  String category;
  List<String> categorySelect = ["Desayunos", "Almuerzos", "Cenas", "Asiáticos", "Postres", "Europeos", "Saludables", "Rápidos", "Suramericanos", "Veganos", "Vegetarianos", "Del Mundo"];
  List<String> dificultySelect = ["1/5", "2/5", "3/5", "4/5", "5/5"];
  List<String> hoursSelect = ["0h", "1h", "2h", "3h"];
  List<String> minsSelect = ["0m", "10m", "20m", "30m", "40m", "50m"];
  //List<String> unitsSelect = ["Unidad(es)","Cucharada(s)", "Cucharadita(s)", "Pizca(s)", "Libra(s)", "Miligramo(s)", "Gramo(s)", "Mililitro(s)", "Litro(s)", "Vaso(s)", "Taza(s)", "Cuarto(s)"];
  List<String> unitsSelect = ["Unidades","Cucharadas", "Cucharaditas", "Pizcas", "Libras", "Miligramos", "Gramos", "Mililitros", "Litros", "Vasos", "Tazas", "Cuartos"];
  String _selectedType = "Categoría";
  String _selectedDif = "Dificultad";
  String _selectedHours = "Horas";
  String _selectedMins = "Minutos";
  List<String> _selectedUnits = [];
  String calories;
  String portions;
  String dificulty;
  String hours;
  String mins;
  String description;
  List<String> tips= List();
  List<String> procedure= List();
  List<String> serve= List();
  List<String> quantity = List();
  List<String> quantityText = [];
  List<String> item = List();
  String path;
  File myImg;
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
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(_selectedType),
                    items: categorySelect.map((String myCategory) {
                      return DropdownMenuItem<String>(
                        value: myCategory,
                        child: Text(myCategory)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      _selectedType = value;
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
                      ),
                ),
             ],
            ),
          );
  }

  Widget _dificultyHoursMinutes(context){ 
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
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(_selectedDif),
                    items: dificultySelect.map((String myDificulty) {
                      return DropdownMenuItem<String>(
                        value: myDificulty,
                        child: Text(myDificulty)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      _selectedDif = value;
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
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(_selectedHours),
                    items: hoursSelect.map((String myHours) {
                      return DropdownMenuItem<String>(
                        value: myHours,
                        child: Text(myHours)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      _selectedHours = value;
                      hours = value;
                      setState(() {});
                    },
                  )
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: width/divisor,
                  color: Colors.grey[200],                  
                  child: DropdownButton(
                    underline: Container(height: 3, color: Colors.deepOrange[300]),
                    iconSize: 24,
                    elevation: 12,
                    dropdownColor: Colors.grey[200],
                    focusColor: Colors.grey[200],
                    hint: Text(_selectedMins),
                    items: minsSelect.map((String myMinutes) {
                      return DropdownMenuItem<String>(
                        value: myMinutes,
                        child: Text(myMinutes)
                        );
                    }).toList(), 
                    onChanged: (String value) {
                      _selectedMins = value;
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

  Widget _ingredient(context, int i){
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
                              if(!isNumeric(value)){
                                return "Deber ser un número entero o decimal";
                              }
                              return null;
                            },
                            maxLines: 1,
                            onChanged: (String value) {
                             if(value == "1"){
                              setState(() {
                                unitsSelect = ["Unidad","Cucharada", "Cucharadita", "Pizca", "Libra", "Miligramo", "Gramo", "Mililitro", "Litro", "Vaso", "Taza", "Cuarto"];
                              });                              
                             }else{
                              setState(() {
                              unitsSelect = ["Unidades","Cucharadas", "Cucharaditas", "Pizcas", "Libras", "Miligramos", "Gramos", "Mililitros", "Litros", "Vasos", "Tazas", "Cuartos"];
                              });
                             }           
                            },
                            onSaved: (String value) {
                              quantity.add(value);            
                            },
                            fontSize: font,
                          ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: width/divisor,
                      color: Colors.grey[200],                  
                      child: DropdownButton(
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
                        hint: Text(_selectedUnits[i]),
                        items: unitsSelect.map((String myUnit) {
                          return DropdownMenuItem<String>(
                            value: myUnit,
                            child: Text(myUnit)
                            );
                        }).toList(), 
                        onChanged: (String value) { 
                          _selectedUnits[i] = value;                       
                     
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
                          ),
                    ),
                ],
                ),
              ]
            )
          );
  }

  bool isNumeric(String s){
    return double.tryParse(s) != null;
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
                    height: 40.0,
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
                    height: 40.0,
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
                    height: 40.0,
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
                    width: 220.0,
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
       if(myImg != null){
       return Container(      
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),         
            height: MediaQuery.of(context).size.width/4,
            width: MediaQuery.of(context).size.width/2,
           child: Image.file(myImg)     
          );  
       }else{
         return Container();
       }
  } 

  Widget _raisedButton(){
     return Container(
            margin: EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: 
            RaisedButton(
            color: Colors.orangeAccent,
            onPressed: () {
              dataBloc = DataBloc();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                dataBloc.add(AddRecipe(title,category,calories,portions,dificulty,hours,
                mins,description,tips,procedure,serve,quantity,_selectedUnits,item,myImg));
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
    List<Widget> list = List();

    list.add(_titleField(context));
    list.add(_categoryCaloriesPortions(context));
    list.add(_dificultyHoursMinutes(context));
    list.add(_description(context));
    list.add(_ingredientsText("Ingredientes:"));
    for(int i=0; i<_counter; i++){
      list.add(_ingredient(context,i)); 
    }
    list.add(_ingredientsPlus());
    list.add(_ingredientsText("Tips y Claves de la Receta:"));
    for(int i=0; i<_counterTip; i++){
      list.add(_tips(context,i)); 
    }
    list.add(_tipsPlus());
    list.add(_ingredientsText("Procedimiento de Cocción:"));
    for(int i=0; i<_counterProcedure; i++){
      list.add(_procedure(context,i)); 
    }
    list.add(_procedurePlus());
    list.add(_ingredientsText("Pasos para Servir:"));
    for(int i=0; i<_counterServe; i++){
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
MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.maxLines,
    this.fontSize,
  });
@override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
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
