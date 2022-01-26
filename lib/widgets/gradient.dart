import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget{
  final String title;
  final double gradientHeight;
  GradientBack(this.title, this.gradientHeight);

  @override
  Widget build(BuildContext context) {
  
  final gradientRectangle = Container(   
    height: gradientHeight,
    decoration: BoxDecoration(
      gradient: LinearGradient(    //Gradiente lineal horizontal
        colors: [
          Color(0xFFC6FAFF),
          Color(0xFF58F3EC),
        ],
        begin: FractionalOffset(0.6,0.4),
        end: FractionalOffset(1.0, 1.0),
        stops: [0.0,1.0],
        tileMode: TileMode.clamp, 
        )
     ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: "Balsamiq",
        fontWeight: FontWeight.bold,
      ),
    ),
    alignment: Alignment(-0.9, -0.6),
  );

  return gradientRectangle;
  }
}