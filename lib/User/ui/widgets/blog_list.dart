import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/screens/tip_list_screen.dart';
import 'package:oliva/User/ui/widgets/blog_card.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class BlogList extends StatefulWidget{

  BlogList();
  @override
  State createState() {    
        return _BlogList();
  }
}

class _BlogList extends State<BlogList> {
   
  DataBloc dataBloc;
  @override
  void initState() {      
      dataBloc = DataBloc();
      dataBloc.add(BuildBlogToday());
      super.initState();  
  }

 @override
 Widget build(BuildContext context) {

  var title = Container( 
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Blogs Imperdibles",
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
                                builder: (BuildContext context) => TipListScreen("blogs"),
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
  
  return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is TipTodayDone){  
            return Container(
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          title,                
                        ],),
                        Container(
                          height: 300.0,
                          child: ListView(
                            padding: EdgeInsets.all(30.0),
                            scrollDirection: Axis.horizontal,         //el scroll va a ser horizontal
                            children: <Widget>[
                              BlogCard(state,0),
                              BlogCard(state,1),
                              BlogCard(state,2),
                              BlogCard(state,3),
                            ],
                          ),
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
}