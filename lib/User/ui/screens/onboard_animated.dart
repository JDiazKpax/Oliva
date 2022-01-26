
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oliva/widgets/onboard_pager_indicator.dart';
import 'package:oliva/widgets/onboard_pages.dart';
import 'package:oliva/widgets/onboard_page_dragger.dart';
import 'package:oliva/widgets/onboard_page_reveal.dart';

class OnboardAnimated extends StatefulWidget {

  @override
  State createState() => new _OnboardAnimated();
}

class _OnboardAnimated extends State<OnboardAnimated> with TickerProviderStateMixin {
  //Todo esto es para asignar valores a las variables que se usarán en el build de esta clase
  //para crear las pantallas de onboard. Los valores vendrán por el Stream de acuerdo a la animación.
  //Creo un objeto de tipo AnimatedPageDragger
   AnimatedPageDragger animatedPageDragger;
   //defino un objeto tipo Stream:
   // ignore: close_sinks
   StreamController<SlideUpdate> slideUpdateStream;
   //En cual página estoy
   int activeIndex = 0 ;

   //Creo un objeto de tipo SlideDirection, es decir un enum con alguno de estos valores:
   //  leftToRight, rightToLeft, none,
   SlideDirection slideDirection = SlideDirection.none;
   //indice de la siguiente página:
   int nextPageIndex = 0 ;
   double slidePercent= 0.0;
   
  _OnboardAnimated() {
     
  
    //Creo el Stream donde puedo ponerle datos de tipo SlideUpdate que tiene 3 variables:
    //final updateType;
    //final direction;
    //final slidePercent;
    slideUpdateStream = new StreamController<SlideUpdate>();

    //Creo una trampa para obtener los paquetes:
    //La función dentro de listen es lo que hace cuando "oye" un dato del tipo SlideUpdate
    slideUpdateStream.stream.listen((SlideUpdate event){
      //Limpiar la pantalla cada vez que recibe un dato del Stream:
      setState(() {
        //en caso en que el dato "updateType" sea "dragging", defino la dirección, porcentaje de visibilidad,
        //e indice de siguiente página
        if( event.updateType == UpdateType.dragging){
          //el objeto slideDirection será la dirección indicada en el dato del Stream:
          slideDirection = event.direction;
          //el objeto slidePercent será el porcentaje indicado en el dato del Stream:
          slidePercent = event.slidePercent;

          //si la dirección del dedo es "Izquierda a Derecha":
          if( slideDirection == SlideDirection.leftToRight ){
              //Siguiente página será una menos a la que está activa:
              nextPageIndex = activeIndex - 1;
          //si la dirección del dedo es "Derecha a Izquierda":
          } else if (slideDirection == SlideDirection.rightToLeft){
              //Siguiente página será una más a la que está activa:
              nextPageIndex = activeIndex + 1;
          //si la dirección es "None" es porque ya terminó de moverse el dedo y llegó al final:
          } else{
             //siguiente página es la que está activa.
              nextPageIndex = activeIndex;
          }
          //en caso en que el dato "updateType" sea "doneDragging", defino el 
          //objeto animatedPageDragger y ejecuto la animación:
        } else if( event.updateType == UpdateType.doneDragging){
          //si el objeto porcentaje es mayor a 0.5:
          if(slidePercent > 0.5){
            //llamo a la clase AnimatedPageDragger con los siguientes valores:
            animatedPageDragger = new AnimatedPageDragger(
              //dirección es la que recibo del dato del Stream:
              slideDirection: slideDirection,
              //transitionGoal puede ser open o close, en este caso es open:
              transitionGoal: TransitionGoal.open,
              //porcentaje es el que recibo del dato del Stream:
              slidePercent: slidePercent,
              //slideUpdateStream es todo el Stream creado:
              slideUpdateStream: slideUpdateStream,
              //tipo de ticker para la animación, fijamos el por defecto:
              vsync: this,
            );
          //si el objeto porcentaje es menor a 0.5:
          } else{
            //llamo a la clase AnimatedPageDragger con los siguientes valores:
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              //transitionGoal puede ser open o close, en este caso es close:
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          }
          //llamo al método run dentro de la clase AnimatedPageDragger que ejecuta la animación:
          animatedPageDragger.run();
        //en caso en que el dato "updateType" sea "animating", defino la dirección y el porcentaje de visibilidad:
        }
        else if( event.updateType == UpdateType.animating){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }
        //en caso en que el dato "updateType" sea "doneAnimating", defino el indice de
        //la página actual, la dirección como ninguna, el porcentaje de visibilidad como 0 y elimino la animación:
        else if (event.updateType == UpdateType.doneAnimating){
          //si transitionalGoal es "open", es decir, porcentaje>0.5:
          if (animatedPageDragger?.transitionGoal == TransitionGoal.open) {
            //indice de la página activa es la siguiente página
            activeIndex = nextPageIndex;
          }
          //dirección es ninguna
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          //finalizo la animación llamando al método dispose dentro de la clase AnimatedPageDragger
          animatedPageDragger.dispose();
        }
      });
    });
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //crea la página onboard a mostrar actualmente
          OnboardPage(
              //traigo la variable pages y selecciono la que esté activa de acuerdo al Stream
            viewModel: pages[activeIndex],
            percentVisible: 1.0 ,
          ),
          //crea la animación de apertura ovalada hacia arriba y la siguiente página
          PageReveal(
            revealPercent: slidePercent,
            //crea la página onboard que va a ser la siguiente a mostrar
            child: OnboardPage(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent ,
            ),
          ),
          //Crea el inidicador y Bubble de indices de página
          Container(
            margin: EdgeInsets.only(
                              top: 750.0,
                            ),
         child: PagerIndicator(
              viewModel: PagerIndicatorViewModel(
                  pages,
                  activeIndex,
                  slideDirection,
                  slidePercent,
              ),
          )),
          //crea el arrastrador de página
          PageDragger(
            canDragLeftToRight: activeIndex > 0 ,
            canDragRightToLeft: activeIndex < pages.length - 1 ,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}