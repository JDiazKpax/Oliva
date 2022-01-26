import 'package:flutter/material.dart';
import 'package:oliva/User/ui/screens/category_detail_screen.dart';

class CategoryListContent extends StatelessWidget{

  CategoryListContent();

  @override
  Widget build (BuildContext context) {
    
    return Container(
      child: 
        Column(
          children: <Widget>[
            _card(context,"Desayunos","assets/img/breakfast_category.jpg"),
            _card(context,"Almuerzos","assets/img/lunch_category.jpg"),
            _card(context,"Cenas","assets/img/dinner_category.jpg"),
            _card(context,"Asiáticos","assets/img/asian_category.jpg"),
            _card(context,"Postres","assets/img/desserts_category.jpg"),
            _card(context,"Europeos","assets/img/european_category.jpg"),
            _card(context,"Saludables","assets/img/healthy_category.jpg"),
            _card(context,"Rápidos","assets/img/quick_category.jpg"),
            _card(context,"Suramericanos","assets/img/sudamerican_category.jpg"),
            _card(context,"Veganos","assets/img/vegan_category.jpg"),
            _card(context,"Vegetarianos","assets/img/vegetarian_category.jpg"),
            _card(context,"Del Mundo","assets/img/world_category.jpg")
          ]
        )
    );
  }

  Widget _card(context, String category, String pathImage){
    double width = MediaQuery.of(context).size.width;
    return Container(                   
             child:
               Column(
                  children: <Widget>[                              
                      Row(
                        children: <Widget>[
                          Expanded(
                          child:
                          Container(
                                margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0
                                ),
                                child:                            
                                  Text(
                                    "$category:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 20.0,
                                      fontFamily: "Aristotelica",
                                    ),
                                  ),
                              ), 
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[ 
                          Expanded(
                          child:
                           InkWell(                 //Para crear un botón personalizado
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => CategoryDetailScreen(category),
                                  )
                                );
                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                            child:
                              Container(
                                margin: EdgeInsets.only(
                                  //top: 20.0,
                                  left:0.0
                                ),
                                height: 150.0,
                                width: width,
                                decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(pathImage), 
                                  ),
                                ),      
                              ),
                           ),
                          ),
                        ],
                       ),
                       
                      ],
                    ), 
           );    
  }
}