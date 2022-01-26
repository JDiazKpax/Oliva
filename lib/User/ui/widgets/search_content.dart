import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class SearchContent extends StatefulWidget{

  final String textSearch;
  SearchContent(this.textSearch);

  @override
  State createState() {    
        return _SearchContent();
  }
}

class _SearchContent extends State<SearchContent> {
  DataBloc dataBloc;
  var image;
  var bottomText;
  var eliminado = "no quitar";
  int counter = 0;
  @override
  void initState() {
         super.initState();
  }

  @override
  Widget build (BuildContext context) {
  dataBloc = DataBloc();
  dataBloc.add(BuildSearchResult(widget.textSearch));

   return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is SearchResultDone){  
              return Container(
                      margin: EdgeInsets.only(
                        bottom: 40.0
                      ),
                      child:
                        Column(
                          children: _cardContent(context,state),
                        )
              );
            }else{
                    return LoadingIndicator();
            }
          }
      )
    ); 
   } 

  Widget _card(int index, context, String imgUrl, String title, String category, String uid) {
   double width = MediaQuery.of(context).size.width;
   return InkWell(                 //Para crear un botón personalizado
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) { 
                     return RecipeScreen(uid);                    
                  }
                )
              );
            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
            child:
              Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),    
              child: 
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          margin: EdgeInsets.only(
                            top: 10.0,
                            right: 15.0,
                            left: 20.0
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,                //que quede en todo el container
                                image: CachedNetworkImageProvider(imgUrl)
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
                      )
                      ]
                    ),                  
                    Container( 
                      width: width/1.7,
                      child: 
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[                               
                                  Flexible(child:                           
                                    Text(
                                    title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 20.0,
                                      fontFamily: "Nunito",
                                    ),
                                    ),
                               ),
                            ],
                          ),
                          Row(
                            children: <Widget>[                               
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  child:                            
                                    Text(
                                    category,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF663300),
                                      fontSize: 18.0,
                                      fontFamily: "Nunito",
                                    ),
                                    ),
                                ),
                            ],
                          ),  
                        ]
                      ),
                    ),
   //                 ) 
                  ]
                )
              )
            );
  } 

  Widget _empty(){
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child:
        Text(
          "No se encontró resultados, intenta con otra palabra.",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF663300),
            fontSize: 18.0,
            fontFamily: "Nunito",
          ),
          ),
      );
  } 

  List<Widget> _cardContent(context, SearchResultDone listData){
    List<Widget> list = List();    
    int itemsLength = listData.searchResult.length;
    if(itemsLength>0)
    {
      for(int i=0; i<itemsLength; i++){ 
          list.add(_card(i,context,listData.searchResult[i].recipeData["imgUrl"],listData.searchResult[i].recipeData["name"],listData.searchResult[i].recipeData["category"],listData.searchResult[i].recipeData["uid"]));
      }
    }else{
      list.add(_empty());
    }
    
    return list;
  }
}