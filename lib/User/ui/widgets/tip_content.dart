import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/widgets/button_click.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share_plugin/social_share_plugin.dart';

class TipContent extends StatelessWidget{
  final TipDone data;
  final ScreenshotController screenshotController;
  TipContent(this.data, this.screenshotController);

  @override
  Widget build (BuildContext context) {
  String myText = data.tip[0].text;
  myText = myText.replaceAll(RegExp(r'\\n'), '\n');
  final width = MediaQuery.of(context).size.width;

  var social = Container(  // Sign In Icons
        margin: EdgeInsets.only(
          top: 0.0,
          bottom: 40.0
        ),
                     child: Row(
        children: <Widget>[ 
          ButtonClick(            
            onPressed: () async {
              if(data.tip[0].text.length>159){
                    await SocialSharePlugin.shareToTwitterLink(text: "Encontré esta truco genial en OlivaApp: ${data.tip[0].title}, ${data.tip[0].text.substring(0,160)}...", url: 'https://olivacocina.page.link/R6GT');
              }else{
                    await SocialSharePlugin.shareToTwitterLink(text: "Encontré esta receta genial en OlivaApp: ${data.tip[0].title}, ${data.tip[0].text.substring(0,data.tip[0].text.length)}...", url: 'https://olivacocina.page.link/R6GT');
              } 
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/twitter2.png",
            buttonLeft: width/2.8,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),
            ButtonClick(
            onPressed: () async {
              File file = await screenshotController.capture(pixelRatio: 2.0);
              await SocialSharePlugin.shareToFeedFacebook(path: file.path);
             // await SocialSharePlugin.shareToFeedFacebookLink(quote: 'Yo recomiendo Oliva, una app genial para cocinar de manera diferente, gestionar fácilmente una lista de compras, descubrir recetas novedosas y saludables y subir mi propias creaciones.', url: 'https://bitbrant.com');
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/facebook2.png",
            buttonLeft: 20.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ), 
             ButtonClick(
            onPressed: () async {
              File file = await screenshotController.capture(pixelRatio: 2.0);
                    await SocialSharePlugin.shareToFeedInstagram(path: file.path);                
            }, 
            buttonHeight: 30.0, 
            buttonWidth: 30.0, 
            imagePath: "assets/img/instagram2.png",
            buttonLeft: 20.0,
            buttonTop:0.0,
            buttonBottom: 0.0,
            buttonRight: 0.0,
            ),                              
          ] 
        )
      );

  var text = Expanded(
              child: 
                Container(
                  margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 50.0
                  ),
                  child: 
                  Text(
                      myText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      color: Color(0xFF663300),
                      fontSize: 18.0,
                      fontFamily: "Nunito"
                      )
                  )
                )
            );

  return Container(
          margin: EdgeInsets.only(
            bottom: 40.0
          ),
          child:
            Column(
              children: <Widget>[  
                social,             
                Row(
                  children: <Widget>[                    
                    
                    text,
                   ],
                ),
               ],
            )
  );

  } 
}