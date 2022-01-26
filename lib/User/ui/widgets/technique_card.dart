import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/tip_list_screen.dart';
import 'package:oliva/User/ui/screens/tip_screen.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class TechniqueCard extends StatefulWidget{

  TechniqueCard();

   @override
  State createState() {    
        return _TechniqueCard();
  }
}

class _TechniqueCard extends State<TechniqueCard> {
   
    DataBloc dataBloc;

    @override
    void initState() {
      
      dataBloc = DataBloc();
      dataBloc.add(BuildTechniqueToday());
      super.initState();  
    }

  @override
  Widget build (BuildContext context) {
  
   var tipButton = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     GestureDetector(                           
                        onTap: () { 
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => TipListScreen("techniques"),
                                    )
                                  );
                         },
                          child:Container(
                             margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                             child: Icon(Icons.control_point, size: 35)
                          ),
                     ),
                    ],
                  );

    return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is TipTodayDone){
             return Container(              
              margin: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: 30.0,
                right: 30.0,
                ),
              decoration: BoxDecoration(               
                borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                 border: Border.all(
                  color: Color(0xFF58F3EC),
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                boxShadow: <BoxShadow>[                                     //crea la sombra del container
                  BoxShadow(
                    color: Color(0xFFE8FDFF),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 7.0)
                  ) 
                ]
              ),
              child:
              Column(
                children: <Widget>[
                    image(state),
                    tipHeader(state),
                    tipTitle(state),
                    tipText(state),
                    tipButton
                ],
              )
            );
            }else{
            return LoadingIndicator();
          }
          }
      )
     );
  }

  Widget tipHeader(TipTodayDone data){
    return Container( 
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Técnica del Chef:",
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
                                builder: (BuildContext context) => TipScreen(data.tipToday[0].uid, "techniques"),
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
  }

  Widget image(TipTodayDone data) {
    String pathImage = data.tipToday[0].pathImage;
    double width = MediaQuery.of(context).size.width;
    return Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(                 //Para crear un botón personalizado
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TipScreen(data.tipToday[0].uid, "techniques"),
                          )
                        );
                    },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                    child:
                      Container(
                      margin: EdgeInsets.only(
                        top: 0.0,
                        left:0.0,
                        right: 0.0,
                        bottom: 20.0
                      ),
                      height: 130.0,
                      width: width-64.0, 
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: CachedNetworkImageProvider(pathImage), 
                        ),
                      ),      
                    ),
                  ),
                 ],
              );
      }

  Widget tipTitle(TipTodayDone data) {
    String title = data.tipToday[0].title;
    return Row(
              children: <Widget>[
                Expanded(child: 
                InkWell(                 //Para crear un botón personalizado
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => TipScreen(data.tipToday[0].uid, "techniques"),
                            )
                          );
                      },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                      child:
                Container(
                margin: EdgeInsets.only(
                    top: 20.0,
                    left:0.0
                  ),
                child:
                  Text(title,
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF663300),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito")),
                ),
                ),
              ),
              ],
            );
  }

  Widget tipText(TipTodayDone data){
    String text = data.tipToday[0].text;
    return Row(
            children: <Widget>[
              Expanded(child:
              InkWell(                 //Para crear un botón personalizado
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TipScreen(data.tipToday[0].uid, "techniques"),
                      )
                    );
                },              //dado que las variables están en la clase superior, se accede a ellas con widget.
                child:
                  Container(
                  margin: EdgeInsets.only(
                      top: 20.0,
                      left:25.0,
                      right: 25.0
                    ),
                  child:
                    Text(text,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF663300),
                        fontSize: 18.0,
                        fontFamily: "Nunito")),
                  ),
              ),
              ),
            ],
          );
  }
}