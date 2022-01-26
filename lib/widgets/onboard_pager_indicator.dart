import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oliva/widgets/onboard_pages.dart';

//clase que crea los botones de navegación
class PagerIndicator extends StatelessWidget {
  //modelo de la clase definida al final del archivo:
  final PagerIndicatorViewModel viewModel;

  PagerIndicator({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // creo una lista que va a tener elementos de tipo PageBubble
    List<PageBubble> bubbles = [];
    //for que cuenta todas las paginas onboard creadas
    for(var i = 0; i < viewModel.pages.length; ++i ){
      final page = viewModel.pages[i];
      //porcentaje de opacidad
      var percentActive;
      //si el for está en la página que está activa:
      if(i == viewModel.activeIndex){
        //opacidad = 1 - cuanto se ve de la otra página
        percentActive = 1.0 - viewModel.slidePercent;
      //si el for está en una página antes de la activa y la dirección es izquierda a derecha:
      } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.leftToRight){
        //opacidad es el porcentaje del slide?
        percentActive = viewModel.slidePercent;
      //si el for está en una página después de la activa y la dirección es derecha a izquierda:
      } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.rightToLeft){
        //opacidad es el porcentaje del slide?
        percentActive = viewModel.slidePercent;
      }else {
        percentActive = 0.0;
      }
      //defino el color del bubble
      bool isHollow = i > viewModel.activeIndex || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.leftToRight);
      
      //agrego un bubble a la lista con las variables de la página onboard del inidice del for
      bubbles.add(
        new  PageBubble(
          viewModel: new PageBubbleViewModel(
              page.color,
              isHollow,
              percentActive,
          ),
        ),
      );
    }
    //ubico los bubbles de acuerdo a cuántos son:
    final bubbleWidth = 55.0 ;
    final baseTranslation = ((viewModel.pages.length * bubbleWidth) / 2) - (bubbleWidth / 2) ;
    var translation = baseTranslation - (viewModel.activeIndex * bubbleWidth);

    if (viewModel.slideDirection == SlideDirection.leftToRight){
        translation += bubbleWidth * viewModel.slidePercent;
    }else if (viewModel.slideDirection == SlideDirection.rightToLeft){
        translation -= bubbleWidth * viewModel.slidePercent;
    }
    //devuelvo una columna con las filas que contienen todos los bubbles
    return Column(
        children: <Widget>[
        //new Expanded(child: new Container()),
        new Transform(
          transform: new Matrix4.translationValues(translation, 0.0, 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}
////opciones de dirección a comparar con el dato que se va a enviar por el Stream:
enum SlideDirection{
  leftToRight,
  rightToLeft,
  none,
}

//variables del inidicador de página, lista de paginas onboard, indice de la pagina actual,
// dirección y porcentaje
class PagerIndicatorViewModel{
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
      this.pages,
      this.activeIndex,
      this.slideDirection,
      this.slidePercent
      );


}

//Clase que crea la burbuja de indice de pagina
class PageBubble extends StatelessWidget {
  //modelo de la clase definida al final del archivo:
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      child: new Center(
        child: new Container(
          width: lerpDouble(20.0,45.0,viewModel.activePercent),
          height: lerpDouble(20.0,45.0,viewModel.activePercent),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow
                ? const Color(0x8800CCFF).withAlpha(0x88 * viewModel.activePercent.round())
                : const Color(0x8800CCFF),
            border: new Border.all(
              color: viewModel.isHollow
                  ? const Color(0x88999999).withAlpha((0x88 * (1.0 - viewModel.activePercent)).round())
                  : Colors.transparent,
              width: 3.0,
            ),
          ),
         /* child: new Opacity(
            opacity: viewModel.activePercent,
            child: Image.asset(
              viewModel.iconAssetPath,
              color: viewModel.color,
            ),
          ),*/
        ),
      ),
    );
  }
}

//variables de la burbuja del inidicador de página, ubicación del icono, color,
// boleano de Hollow y porcentaje de la pagina activa
class PageBubbleViewModel {
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel (
      this.color,
      this.isHollow,
      this.activePercent,
      );


}