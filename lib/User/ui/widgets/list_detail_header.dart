import 'package:flutter/material.dart';
import 'package:oliva/User/model/data_state.dart';

class ListDetailHeader extends StatefulWidget{
  
  final CategoryDone categoryData;
  final String type;

  ListDetailHeader(this.categoryData,this.type);
   
   @override
  State createState() {    
        return _ListDetailHeader();
  }
}

class _ListDetailHeader extends State<ListDetailHeader> {

   @override
    void initState() {
      super.initState();
    }
  
   @override
  Widget build(BuildContext context) {
    String categoryName;
    if(widget.type=="recipes"){ 
      categoryName = widget.categoryData.category[0].categoryName;
    }
    if(widget.type=="tips"){
      categoryName = "Trucos del Chef";
    }
    if(widget.type=="techniques"){
      categoryName = "Técnicas del Chef";
    }
    if(widget.type=="blogs"){
      categoryName = "Blogs";
    }
     var header =  Container(
              decoration: BoxDecoration(               
                color: Color(0xFFC6FAFF),
              ), 
              padding: EdgeInsets.only(bottom: 20.0),
              child:     
              Column(
              children: <Widget>[                   
                  Row(
                    children: <Widget>[
                    Expanded(
                     child:
                      Column(
                        children: <Widget>[                        
                          Row(children: <Widget>[                          
                            GestureDetector(                           
                              onTap: () {
                                Navigator.pop(
                                    context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30.0, left: 20.0),
                                child:Icon(Icons.arrow_back_ios, size: 35)
                              ),
                            ),
                          ],
                          ),
                         ],
                        ),
                      ),
                       Column(                           
                          children: <Widget>[                        
                           Row(  //logo2
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[                      
                                    Container(
                                      alignment: Alignment(0.0,0.0),                                
                                      margin: EdgeInsets.only(
                                        top:30.0,
                                        right:30.0,
                                        bottom: 0.0
                                      ),
                                      height: 50.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/img/logo2.png"), 
                                        ),
                                      ),      
                                    ),
                                ],
                          ),
                         ],  
                       ),
                       ],
                   ),
                   Row(children: <Widget>[],)
              ]
              )
            );   
              
    
  var headerTotal = Container(
                      child:
                        Column(
                          children: <Widget>[
                            header,                            
                          ]
                        )
                  );

  var recipeCategoryInfo = Container(
          child:
           Column(
             children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                        Container(  
                        margin: EdgeInsets.only(
                          top: 20.0,
                          left: 20.0
                        ),  
                        child:        
                          Text(
                            categoryName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF663300),
                              fontSize: 22.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,                                       
                            ), 
                          ),
                        ),
                    ),
                  ],
                ), 
             ]
           )
        );  

      return Container(
        margin: EdgeInsets.only(
          bottom: 30.0,
        ),
        child: Column(
          children: <Widget>[
              headerTotal,
              recipeCategoryInfo              
            ],
        )
      );
   }
}