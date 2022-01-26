import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/recipe_screen.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class InspirationList extends StatelessWidget{
  

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    DataBloc dataBloc;
  dataBloc = DataBloc();
  dataBloc.add(BuildInspirationCards());
  var title = Container(
              margin: EdgeInsets.only(
                  top: 50.0,
                  left: 20.0,
                  bottom: 20.0
                ),
              child:
                Text("Inspiración para tí",
                textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF663300),
                    fontSize: 20.0,
                    fontFamily: "Nunito")),
              ); 
                      
   return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is InspirationDone){
              return Container(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            title,                
                          ],),
                          Row(children: <Widget>[
                            Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,0)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,1)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,2)
                                    ]
                                  )
                                ]
                              ),
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,3)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,4)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,5)
                                    ]
                                  )
                                ]
                              ),
                              /*Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,6)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,7)
                                    ]
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _card(context,state,8)
                                    ]
                                  )
                                ]
                              ),*/
                            ],
                          ),
                          ),                
                          ],
                          ),
                        ]
                      )
              );
              }else{
              return LoadingIndicator();
            }
          }
      )
     );
  } 
 
  Widget _card(context,InspirationDone data, int i){
    double width = MediaQuery.of(context).size.width;
    double tercio = width/3;

    return  InkWell(                 //Para crear un botón personalizado
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) { 
                      return RecipeScreen(data.inspirationRecipes[i].uid);
                   }
                  )
                );
            },              //dado que las variables están en la clase superior, se accede a ellas con widget.
            child:    
              Container(
                height: 150.0,
                width: tercio,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,                //que quede en todo el container
                    image: CachedNetworkImageProvider(data.inspirationRecipes[i].pathImage)
                  ),
                  shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                ),
              )
            );
  }
}