import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliva/widgets/button_click.dart';
import 'package:social_share_plugin/social_share_plugin.dart';

class SocialMedia extends StatelessWidget{

 @override
 Widget build(BuildContext context) {
 double width = MediaQuery.of(context).size.width;
  var title = Container(
              margin: EdgeInsets.only(
                  top: 30.0,
                  left:20.0
                ),
              child:
                Text("Te gusta Oliva? Recomiéndanos",
                textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF663300),
                    fontSize: 18.0,
                    fontFamily: "Nunito")),
              ); 

  var title2 = Container(
               margin: EdgeInsets.only(
                  bottom: 20.0 
                ),
               child:
                Text("Oliva - Cocinemos diferente hoy. 2020",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF663300),
                    fontSize: 18.0,
                    fontFamily: "Nunito")),
              );        
              

  

  var list = Container(  // Sign In Icons
        margin: EdgeInsets.only(
          top: 20.0,
          bottom: 20.0
        ),
        child: Row(
        children: <Widget>[ 
          ButtonClick(            
            onPressed: () async {
                    await SocialSharePlugin.shareToTwitterLink(text: 'Yo recomiendo Oliva, una app genial para cocinar de manera diferente, gestionar fácilmente una lista de compras, descubrir recetas novedosas y saludables y subir mi propias creaciones.', url: 'https://olivacocina.page.link/R6GT');
                  }, 
            buttonHeight: 50.0, 
            buttonWidth: 50.0, 
            imagePath: "assets/img/twitter2.png",
            buttonLeft: (width/2)-100.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),
            ButtonClick(
            onPressed: () async {
             // File file = await ImagePicker.pickImage(source: ImageSource.gallery);
             // await SocialSharePlugin.shareToFeedFacebook(path: file.path);
              await SocialSharePlugin.shareToFeedFacebookLink(quote: 'Yo recomiendo Oliva, una app genial para cocinar de manera diferente, gestionar fácilmente una lista de compras, descubrir recetas novedosas y saludables y subir mi propias creaciones.', url: 'https://olivacocina.page.link/R6GT');
            }, 
            buttonHeight: 50.0, 
            buttonWidth: 50.0, 
            imagePath: "assets/img/facebook2.png",
            buttonLeft: 30.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ), 
             ButtonClick(
            onPressed: () async {
              File file = await ImagePicker.pickImage(source: ImageSource.gallery);
                    await SocialSharePlugin.shareToFeedInstagram(path: file.path);                
            }, 
            buttonHeight: 50.0, 
            buttonWidth: 50.0, 
            imagePath: "assets/img/instagram2.png",
            buttonLeft: 30.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),                              
          ] 
        )
      );
  
  var union = Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                title,                
              ],),
              list,
              title2

            ]
          )
  ); 

  return union;
 }
}