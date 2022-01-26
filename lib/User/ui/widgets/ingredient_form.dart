import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/user.dart';

class IngredientForm extends StatefulWidget {
   
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
   

  IngredientForm({
    this.hintText,  
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });
  @override
  State createState() {    
        return _IngredientForm();
  }
}

class _IngredientForm extends State<IngredientForm> {
  DataBloc dataBloc;
  List<IngredientFormModel> ingredientModel = [];
  String temp1;
  String temp2;
  String temp3;
  String path;
  File myImg;
  Widget myWidget;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
         super.initState();
  }

  @override
  Widget build(BuildContext context) {

  if(myImg == null){
    myWidget = Text("");
  }else{
    myWidget = Image.file(myImg);
  }

  final halfMediaWidth = MediaQuery.of(context).size.width / 2.4;
  final halfMediaWidth2 = MediaQuery.of(context).size.width / 2;
  final mediaWidth = MediaQuery.of(context).size.width / 1.2;
  return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 50.0,left: 0.0),
            width: mediaWidth,
            child: MyTextFormField(
                    hintText: 'Nombre del Item',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Ingresa el nombre del item';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      ingredientModel.add(IngredientFormModel(
                        item: value,
                      ));
                    },
                  ),
            
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 10.0,left: 37.0,bottom:30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Cantidad en número',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Ingresa la cantidad numérica de items que necesitas';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      ingredientModel.add(IngredientFormModel(
                        quantity: value,
                      ));
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child:
                    MyTextFormField(
                      hintText: 'Unidades',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Ingresa las unidades que necesitas (p. ej. Libras o Unidades.)';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                         ingredientModel.add(IngredientFormModel(
                            quantityText: value
                          ));             
                     
                        },
                      ),
                ),
              ]
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0, bottom: 30.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[              
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: halfMediaWidth2,
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
          ),
          Container(      
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),         
            height: MediaQuery.of(context).size.width/4,
            width: MediaQuery.of(context).size.width/2,
            child: myWidget,     
          ),
          RaisedButton( 
            color: Colors.blueAccent,
            onPressed: () {
              dataBloc = DataBloc();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                dataBloc.add(AddIngredient(ingredientModel[0].item,ingredientModel[1].quantity,ingredientModel[2].quantityText,myImg));
                 Navigator.pop(context);
              }
           },
            child: Text(
              'Guardar en Lista de Compras',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}