import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/ui/widgets/tip_content.dart';
import 'package:oliva/User/ui/widgets/tip_header.dart';
import 'package:oliva/widgets/loading_inidicator.dart';
import 'package:screenshot/screenshot.dart';

class TipScreen extends StatefulWidget {

  final String uid;
  final String type;
  TipScreen(this.uid, this.type);

  @override
  State createState() {    
        return _TipScreen();
  }
}

class _TipScreen extends State<TipScreen> {
    
    DataBloc dataBloc;
    ScreenshotController screenshotController = ScreenshotController();
    @override
    void initState() {
      dataBloc = DataBloc();
      if(widget.type == "tips"){      
        dataBloc.add(BuildTip(widget.uid));
      }
      if(widget.type == "techniques"){      
        dataBloc.add(BuildTechnique(widget.uid));
      }
       if(widget.type == "blogs"){      
        dataBloc.add(BuildBlog(widget.uid));
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
           if(state is TipDone){
            return Scaffold(
              body:Screenshot(
              controller: screenshotController,
              child:
              ListView(
                children: <Widget>[
                TipHeader(state),
                TipContent(state, screenshotController),
                ]
              )
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