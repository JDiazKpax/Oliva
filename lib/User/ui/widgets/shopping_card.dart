import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';

class ShoppingCard extends StatefulWidget{

  final String pathImage;
  final String item;
  final String quantity;
  final String quantityText;
  final List<List<dynamic>> buyed;
  ShoppingCard(this.pathImage,this.item,this.quantity,this.quantityText,this.buyed);

   @override
  State createState() {    
        return _ShoppingCard();
  }
}

class _ShoppingCard extends State<ShoppingCard> {
  DataBloc dataBloc;
  var image;
  var bottomText;
  var eliminado = "no quitar";
  TextDecoration myDecoration;
  FontStyle myStyle;
  int myColor;
  bool checked = false;
  IconData myIcon = Icons.check_box_outline_blank;
  @override
  void initState() {
         super.initState();
  }

  @override
  Widget build (BuildContext context) {
  if(widget.buyed.length != 0){
    if(widget.buyed[0].length != 0){
        for(int j =0; j<widget.buyed.length; j++){     
          if(widget.item == widget.buyed[0][j]){
            myDecoration = TextDecoration.lineThrough;
            myStyle = FontStyle.italic;
            myColor = 0xFF999999;
            myIcon = Icons.check_box;
            break;
          }else{
            myDecoration = null;
            myStyle = null;
            myColor = 0xFF663300;
            myIcon = Icons.check_box_outline_blank;
          }
        }
      }else{
        myDecoration = null;
        myStyle = null;
        myColor = 0xFF663300;
        myIcon = Icons.check_box_outline_blank;
      }
  }else{
      myDecoration = null;
      myStyle = null;
      myColor = 0xFF663300;
      myIcon = Icons.check_box_outline_blank;
    }

  if(eliminado == "comprado"){
         myDecoration = TextDecoration.lineThrough;
          myStyle = FontStyle.italic;
          myColor = 0xFF999999;
          myIcon = Icons.check_box;
    }

  if(eliminado == "sin comprar"){
         myDecoration = null;
        myStyle = null;
        myColor = 0xFF663300;
        myIcon = Icons.check_box_outline_blank;
  }

  if(eliminado!="quitar"){
    image = Container(
                height: 250.0,
                width: 200.0,
                margin: EdgeInsets.only(
                  left: 20.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,                //que quede en todo el container
                    image: CachedNetworkImageProvider(widget.pathImage)
                  ),
                  shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                  boxShadow: <BoxShadow>[                                     //crea la sombra del container
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 7.0)
                    ) 
                  ]
                ),
            );

    bottomText = Container(
        margin: EdgeInsets.only(
        top: 110.0,
        left: 20.0,           
        ),
        decoration: BoxDecoration(               
          color: Color(0XFFDDF4FF),         
        ),
        height:70.0, 
        child:     
        Row(children: <Widget>[
          Container(
          width: 125.0,
          margin: EdgeInsets.only(left:10.0),            
          child:
          Column(
            children: <Widget>[ 
              Row(
              children: <Widget>[
                  Flexible(
                    child:
                    Text(
                      widget.item,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: myDecoration, 
                        fontStyle: myStyle,
                        color: Color(myColor),
                        fontSize: 18.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ), 
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child:  
                    Text(
                      "${widget.quantity} ${widget.quantityText}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: myDecoration, 
                        fontStyle: myStyle,
                        color: Color(myColor),
                        fontSize: 14.0,
                        fontFamily: "Nunito",
                      ), 
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
            Column(
              children: <Widget>[
                  Row(
                    children: <Widget>[ 
                      Container(
                        margin: EdgeInsets.only(right:4.0),
                        child:                               
                        InkWell(                           
                        onTap: () {
                            _removeItem(widget.item,widget.quantity,widget.quantityText,widget.pathImage);
                        },
                        child:
                        Icon(Icons.cancel, size: 30,)
                        ),
                      )
                    ]
                  )
              ],
            ),
            Column( 
              children: <Widget>[
                  Row(
                    children: <Widget>[                                                      
                      InkWell(                           
                      onTap: () {
                           if(checked == true){
                                    _unbuyedItem(widget.item);
                                  }else{
                                    _buyedItem(widget.item);
                                  } 
                      },
                      child:
                        Icon(myIcon, size: 30)
                      ),
                    ]
                  )
              ]
           )               
        ],
       ),
      );
  }else{
    image = Container();
    bottomText = Container();
  }

  return Stack(
    children: <Widget>[      
      image,
      bottomText,
    ],
  );

  }

  void _removeItem(String ingredient, String quantity, String quantityString,String imgUrl) {
    dataBloc = DataBloc();
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildAboutDialog(context),
    ).then((value) {
      if(value == true){
        dataBloc.add(RemoveIngredient(ingredient,quantity,quantityString,imgUrl));
        setState(() {
          eliminado = "quitar";
        });
      }
    });   
  }

  void _buyedItem(String ingredient) {
    dataBloc = DataBloc();
    dataBloc.add(BuyedIngredient(ingredient));
    setState(() {
      eliminado = "comprado";
      checked = true;
    });
  }

  void _unbuyedItem(String ingredient) {
    dataBloc = DataBloc();
    dataBloc.add(UnBuyedIngredient(ingredient));
    setState(() {
      eliminado = "sin comprar";
      checked = false;
    });
  }

  Widget _buildAboutDialog(BuildContext context){
    return AlertDialog(
      content: Builder(
        builder: (context){
            double height = MediaQuery.of(context).size.height; 
            return Container(
              height: height/4,
              child:Column(
                children: <Widget>[
                  Icon(Icons.warning),
                  Text(
                "Estás seguro de eliminar el ingrediente de tu lista de compras?",
                textAlign: TextAlign.center,
                style: TextStyle(                                      
                  fontSize: 20.0,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF663300),
                )
              ),
                ],
              ),
            );
        },        
        ),  
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          textColor: Colors.deepOrange, 
          child: Text(
        "Sí",
        textAlign: TextAlign.center,
        style: TextStyle(                                      
          fontSize: 20.0,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w700,
          color: Color(0xFF663300),
        )
      ),
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          textColor: Colors.deepOrange, 
          child:Text(
        "No",
        textAlign: TextAlign.center,
        style: TextStyle(                                      
          fontSize: 20.0,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w700,
          color: Color(0xFF663300),
        )
      ),
        )
      ],
    );
  }
}