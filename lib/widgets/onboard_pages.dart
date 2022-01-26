import 'package:flutter/material.dart';

//variable para crear las diferentes páginas onboard.
//usa la clase PageViewModel declarada al final de este archivo
final pages = [
  new PageViewModel(
      const Color(0xFFFAEEFD),
      'assets/img/onboard1.jpg',
      'Inspírate',
      'Con miles de recetas fáciles y saludables.',
      "",
      Icon(Icons.navigate_next)),
  new PageViewModel(
      const Color(0xFFD7FFEF),
      'assets/img/onboard2.jpg',
      'Crea',
      'Tus propias recetas con los ingredientes que tengas. Nuestros chefs te podrán orientar.',
      '',
      Icon(Icons.navigate_next)),
  new PageViewModel(
      const Color(0xFFFFE8E1),
      'assets/img/onboard3.jpg',
      'Comparte',
      'Tus creaciones y recetas favoritas. Una comunidad te estará esperando.',
      '',
      Icon(Icons.navigate_next)),
  new PageViewModel(
      const Color(0xFFD9ECFF),
      'assets/img/onboard4.jpg',
      'Alcanza',
      'Tus objetivos. Fijate una meta calórica, Oliva encontrará las recetas ideales que te ayudarán a cumplirla.',
      '',
      Icon(Icons.navigate_next)),
  new PageViewModel(
      const Color(0xFFFBFFEA),
      'assets/img/onboard5.jpg',
      'Gestiona',
      'Tu lista de compras fácilmente de acuerdo a las recetas que vayas a preparar.',
      'Vamos a la app!',
      Icon(Icons.cake)),
];

//clase que crea las páginas de onboard, requiere las variables de la clase
//PageviewModel definida al final de este archivo y el porcentaje de visibilidad
class OnboardPage extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  OnboardPage({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child:
            new Opacity(
              opacity: percentVisible,
              child: new Column(
                    children: [
                    //Imagen del Onboard
                    new Transform(
                      transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible) ,0.0),
                      child: new Padding(
                          padding: new EdgeInsets.only(bottom: 25.0),
                          child: Container(      //Image
                            margin: EdgeInsets.only(
                              top: 50.0,
                            ),
                            height: 200.0,
                            width: 330.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(viewModel.heroAssetPath) 
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),      //borde redondeado
                              shape: BoxShape.rectangle,                                  //la forma del containe debe ser rectangular
                              boxShadow: <BoxShadow>[                                     //crea la sombra del container
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 7.0)
                                ) 
                              ]
                            ),      
                          ),
                      ),
                    ),
                    //escribe el título del Onboard
                    new Transform(
                      transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
                      child: new Padding(
                          padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(     //Title
                              margin: EdgeInsets.only(
                                top: 15.0,
                              ),
                              child: Text(
                                        viewModel.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xFF663300),
                                          fontSize: 20.0,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w700,
                                        ),   
                                    ),
                            ),
                          ),
                      ),
                    
                    //cuerpo del Onboard
                    new Transform(
                      transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
                      child: new Padding(
                          padding: new EdgeInsets.only(bottom: 10.0),
                          child: Container(     //Body text
                            margin: EdgeInsets.only(
                              top: 10.0,
                              left: 40.0,
                              right: 40.0,
                            ),
                            child: Text(
                                viewModel.body,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: 18.0,
                                  fontFamily: "Nunito",
                                ),  
                              ), 
                          ),
                      ),
                    ),
                    new Transform(
                      transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
                      child: new Padding(
                          padding: new EdgeInsets.only(top: 0.0, bottom: 0.0),
                          child: Container(     //Title
                              margin: EdgeInsets.only(
                                top: 15.0,
                              ),
                              child: viewModel.next,   
                          ),
                      ),
                    ),
                    //Texto de Finalizar
                    GestureDetector(
                      onTap: () {
                       Navigator.pop(context);
                      },
                      child: Transform(
                        transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
                        child: Center(
                          child: Text(
                                  viewModel.endText,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF663300),
                                    fontSize: 20.0,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),  
                                ),
                             ),
                      ),
                    ),
                  ]),
            ));
  }
}

//clase que contiene las variables de cada página de onboard:
class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String endText;
  final Icon next;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.endText,
    this.next
  );
}