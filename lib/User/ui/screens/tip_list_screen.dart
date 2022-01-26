import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/ui/widgets/list_detail_content.dart';
import 'package:oliva/User/ui/widgets/list_detail_header.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class TipListScreen extends StatefulWidget {
  
  final String type;
  TipListScreen(this.type);

  @override
  State createState() {    
        return _TipListScreen();
  }
}

class _TipListScreen extends State<TipListScreen> {
   
    DataBloc dataBloc;
    
    @override
    void initState() {
      dataBloc = DataBloc();
      if(widget.type == "tips"){   
        dataBloc.add(BuildTipList());
      }
      if(widget.type == "techniques"){
        dataBloc.add(BuildTechniqueList());
      }
      if(widget.type == "blogs"){
        dataBloc.add(BuildBlogList());
      }
      super.initState();
    }
   
   @override
   Widget build(BuildContext context) {
     return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
           if(state is CategoryDone){    
              return Scaffold(
                body:ListView(
                  children: <Widget>[
                  ListDetailHeader(state,widget.type),
                  ListDetailContent(state,widget.type),
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