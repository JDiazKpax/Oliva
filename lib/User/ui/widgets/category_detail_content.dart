import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';
import 'package:oliva/User/ui/screens/recipes_list_screen.dart';

class CategoryDetailContent extends StatelessWidget{

  final CategoryDone categoryData;
  CategoryDetailContent(this.categoryData);

  @override
  Widget build (BuildContext context) {

  String description = categoryData.category[0].recipeData["description"];
  
  var more =  Container(              
              margin: EdgeInsets.only(
                top: 30.0,
              ), 
              child: Column(
                        children: <Widget>[                    
                          Row(children: <Widget>[ 
                              Expanded(
                                 child:                         
                            GestureDetector(                           
                              onTap: () {                               
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => RecipesListScreen(categoryData),
                                    )
                                  );            
                              },
                              child: Text(
                                        "Más Recetas",
                                        textAlign: TextAlign.center,                                    
                                        style: TextStyle(
                                        color: Color(0xFF663300),
                                        fontSize: 20.0,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold
                                        ),  
                                      ),
                              ),
                            ),
                          ],
                          ),
                         ],
                      ),
                );

  var content = Container(
                  margin: EdgeInsets.only(
                    left: 15.0,
                    top: 0.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child:
                  Column(
                      children: <Widget>[                        
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:
                                Text(
                                  description,
                                  textAlign: TextAlign.center,                                    
                                  style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 20.0,
                                  fontFamily: "Nunito",
                                  ),  
                                ),
                            ),
                          ]
                        ),
                      ]
                    )
                );


  return Container(
          margin: EdgeInsets.only(
            bottom: 40.0
          ),
          child:
            Column(
              children: <Widget>[               
                content,
                Column(
                  children: _cardContent(context)
                ),
                more,                
              ],
            )

  );

  }

  Widget _card(context, String name1, String uid1, String photo1, String name2, String uid2, String photo2, bool internet) {

  double widthImage = MediaQuery.of(context).size.width/2.6;
  double widthContainer = MediaQuery.of(context).size.width/2.4;

  return  Container(
            child: 
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[  
                          Container(
                              margin: EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 10.0
                              ),
                              width: widthContainer,               
                              child: 
                                Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                            Expanded(
                                            child:
                                            InkWell(                 //Para crear un botón personalizado
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => RecipeScreen(uid1),
                                                  )
                                                );
                                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                                            child:  
                                              Container(
                                                height: 150.0,
                                                width: widthImage,
                                                margin: EdgeInsets.only(
                                                  top: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,                //que quede en todo el container
                                                  //  image: AssetImage("assets/img/onboard1.jpg"), 
                                                   image: internet?CachedNetworkImageProvider(photo1):AssetImage(photo1)
                                                  ),
                                                  shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                                                  boxShadow: <BoxShadow>[                                     //crea la sombra del container
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 5.0,
                                                      offset: Offset(0.0, 2.0)
                                                    ) 
                                                  ]
                                                ),
                                              ),
                                            ),
                                            )
                                          ]
                                      ),                  
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child:                           
                                            Column(
                                              children: <Widget>[                                                              
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child:                            
                                                      Text(
                                                      name1,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xFF663300),
                                                        fontSize: 20.0,
                                                        fontFamily: "Nunito",
                                                      ),
                                                      ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ]
                                      ),
                                    ]
                                  ), 
                          ),
                        ]
                      ),
                      Column(
                        children: <Widget>[  
                          Container(
                              margin: EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 10.0
                              ),
                              width: widthContainer,               
                              child: 
                                Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                            Expanded(
                                            child:
                                            InkWell(                 //Para crear un botón personalizado
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => RecipeScreen(uid2),
                                                  )
                                                );
                                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                                            child:  
                                              Container(
                                                height: 150.0,
                                                width: widthImage,
                                                margin: EdgeInsets.only(
                                                  top: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,                //que quede en todo el container
                                                  //  image: AssetImage("assets/img/onboard1.jpg"), 
                                                   image: internet?CachedNetworkImageProvider(photo2):AssetImage(photo2)
                                                  ),
                                                  shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                                                  boxShadow: <BoxShadow>[                                     //crea la sombra del container
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 5.0,
                                                      offset: Offset(0.0, 2.0)
                                                    ) 
                                                  ]
                                                ),
                                              ),
                                            ),
                                            )
                                          ]
                                      ),                  
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child:                           
                                            Column(
                                              children: <Widget>[                                                              
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child:                            
                                                      Text(
                                                      name2,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xFF663300),
                                                        fontSize: 20.0,
                                                        fontFamily: "Nunito",
                                                      ),
                                                      ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ]
                                      ),
                                    ]
                                  ), 
                          ),
                        ]
                      )
                    ]
                  )
                ]
              )
  );
                        
  }

  Widget _cardReduced(context, String name1, String uid1, String photo1, bool internet) {

  double widthImage = MediaQuery.of(context).size.width/2.5;
  double widthContainer = MediaQuery.of(context).size.width/2.3;

  return  Container(
            child: 
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[  
                          Container(
                              margin: EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 10.0
                              ),
                              width: widthContainer,               
                              child: 
                                Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                            Expanded(
                                            child:
                                            InkWell(                 //Para crear un botón personalizado
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => RecipeScreen(uid1),
                                                  )
                                                );
                                            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                                            child:  
                                              Container(
                                                height: 150.0,
                                                width: widthImage,
                                                margin: EdgeInsets.only(
                                                  top: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,                //que quede en todo el container
                                                  //  image: AssetImage("assets/img/onboard1.jpg"), 
                                                   image: internet?CachedNetworkImageProvider(photo1):AssetImage(photo1)
                                                  ),
                                                  shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                                                  boxShadow: <BoxShadow>[                                     //crea la sombra del container
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 5.0,
                                                      offset: Offset(0.0, 2.0)
                                                    ) 
                                                  ]
                                                ),
                                              ),
                                            ),
                                            )
                                          ]
                                      ),                  
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child:                           
                                            Column(
                                              children: <Widget>[                                                              
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child:                            
                                                      Text(
                                                      name1,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xFF663300),
                                                        fontSize: 20.0,
                                                        fontFamily: "Nunito",
                                                      ),
                                                      ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ]
                                      ),
                                    ]
                                  ), 
                          ),
                        ]
                      ),   
                    ]
                  )
                ]
              )
  );
                        
  }

  List<Widget> _cardContent(context){
    String cat;
    String cat2;
    String cat3;
    List<String> categoryNameList = List();
    List<String> categoryUidList = List();
    List<String> categoryPhotoList = List();
    List<Widget> list = List();
    double recipesLength;
    bool internet = categoryData.category[0].internet;
    recipesLength = ((categoryData.category[0].recipeData.length)-2)/3;

    for(int i=0; i<recipesLength; i++){
      cat =  categoryData.category[0].recipeData["recipeName${i+1}"];
      categoryNameList.add(cat);
      cat2 = categoryData.category[0].recipeData["uid${i+1}"];
      categoryUidList.add(cat2); 
      cat3 = categoryData.category[0].recipeData["photoUrl${i+1}"];
      categoryPhotoList.add(cat3);  

    }

    for(int j=0; j<categoryNameList.length; j++){
      if(j<4)
      {
        if(j+1 < categoryNameList.length){
            list.add(_card(context,categoryNameList[j],categoryUidList[j],categoryPhotoList[j],categoryNameList[j+1],categoryUidList[j+1],categoryPhotoList[j+1],internet));
        }
        else{
            list.add(_cardReduced(context,categoryNameList[j],categoryUidList[j],categoryPhotoList[j],internet));
        }
        j++;
      }
    } 
    return list;
  }
}