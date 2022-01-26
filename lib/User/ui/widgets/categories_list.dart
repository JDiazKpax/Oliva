import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/category_list_screen.dart';
import 'package:oliva/User/ui/widgets/home_screen_card.dart';

class CategoriesList extends StatelessWidget{

 @override
 Widget build(BuildContext context) {

  var title = Container( 
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("El Recetario",
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
                                builder: (BuildContext context) => CategoryListScreen(),
                                )
                              );
                          },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                          child: Icon(Icons.open_in_new)
                        )
                      ]
                    )
                  ]
                )
            );

   var list = Container(
              height: 260.0,
              child: ListView(
                padding: EdgeInsets.all(20.0),
                scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                children: <Widget>[
                  HomeScreenCard("Desayunos","assets/img/breakfast_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Almuerzos","assets/img/lunch_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Cenas","assets/img/dinner_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Asiáticos","assets/img/asian_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Postres","assets/img/desserts_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Europeos","assets/img/european_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Saludables","assets/img/healthy_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Rápidos","assets/img/quick_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Suramericanos","assets/img/sudamerican_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Veganos","assets/img/vegan_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Vegetarianos","assets/img/vegetarian_category.jpg","category",180.0,150.0,0,false,""),
                  HomeScreenCard("Del Mundo","assets/img/world_category.jpg","category",180.0,150.0,0,false,""),
                ],
               ),
              );
  
  var union = Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                title,                
              ],),
              list
            ]
          )
  ); 

  return union;
 }
}