import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/category_detail_content.dart';
import 'package:oliva/User/ui/widgets/list_detail_header.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class CategoryDetailScreen extends StatefulWidget {
  
  final String myCategory;
  
  CategoryDetailScreen(this.myCategory);

  @override
  State createState() {    
        return _CategoryDetailScreen();
  }
}

class _CategoryDetailScreen extends State<CategoryDetailScreen> {
   
    DataBloc dataBloc;
    // ignore: close_sinks
    AuthenticationBloc authBloc;
    
    @override
    void initState() {
      dataBloc = DataBloc();
      dataBloc.add(BuildCategory(widget.myCategory));
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
                ListDetailHeader(state,"recipes"),
                CategoryDetailContent(state),
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