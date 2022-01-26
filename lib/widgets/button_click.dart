import 'package:flutter/material.dart';

class ButtonClick extends StatelessWidget {
  
  final String textButton;
  final String imagePath;
  final VoidCallback onPressed;       //variable que puede recibir una función como parámetro, esto para el onTap
  final double buttonHeight;
  final double buttonWidth;
  final double buttonTop;
  final double buttonBottom;
  final double buttonLeft;
  final double buttonRight;

  ButtonClick(
    {
     Key key, 
     this.textButton,
     @required this.onPressed,
     this.buttonHeight,
     this.buttonWidth,
     this.imagePath, 
     this.buttonTop,
     this.buttonBottom,
     this.buttonLeft,
     this.buttonRight
    }
  );

  @override
  Widget build(BuildContext context) {
    
    final mybutton = InkWell(                 //Para crear un botón personalizado
      onTap: onPressed,              //dado que las variables están en la clase superior, se accede a ellas con widget.
      child: Container(         
        margin: EdgeInsets.only(
          top: buttonTop,
          bottom: buttonBottom,
          left: buttonLeft,
          right: buttonRight,
        ),
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath), 
          ),
        ),    
      )
    );

  return mybutton;
  }
}