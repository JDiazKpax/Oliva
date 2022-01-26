import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oliva/widgets/onboard_pager_indicator.dart';

//clase que al detectar movimiento horizontal de la pantalla inicia el cambio de página
class PageDragger extends StatefulWidget {

  final canDragLeftToRight;
  final canDragRightToLeft;
  final StreamController<SlideUpdate> slideUpdateStream;

  PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
  });

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {

  static const FULL_TRANSTITION_PX = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details){
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      //detecta si se está moviendo de derecha a izquierda o al revés
      if (dx > 0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none){
      slidePercent = (dx / FULL_TRANSTITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }
      //pone un dato en el stream, inidicando que está "dragging" en la dirección indicada y al porcentaje indicado
      widget.slideUpdateStream.add(
          new SlideUpdate(
          UpdateType.dragging,
          slideDirection,
          slidePercent
      ));
    }
  }
  //pone un dato en el stream, inidicando que está "terminó de Drag"
  onDragEnd(DragEndDetails details){
    widget.slideUpdateStream.add(
      new SlideUpdate(
      UpdateType.doneDragging,
      SlideDirection.none,
      0.0,
      )
    );

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart ,
      onHorizontalDragUpdate: onDragUpdate ,
      onHorizontalDragEnd: onDragEnd ,
    );
  }
}

//Clase que anima el cambio de página
class AnimatedPageDragger{

  static const PERCENT_PER_MILLISECOND = 0.005;
  //dirección que viene del dato del Stream:
  final slideDirection;
  //TransitionGoal que viene del llamado a la clase en onboard_animated.
  final transitionGoal;

  //clase de Material
  AnimationController completionAnimationController;

  //constructor que necesita: dirección, transitionGoal, porcentaje, stream 
  //y la clase TickerProvider, que es una clase que es capaz de enviar una señal,
  //como diciendo "Now, now, now", esto para marcar los fps.
  AnimatedPageDragger({
      this.slideDirection,
      this.transitionGoal,
      slidePercent,
      StreamController<SlideUpdate> slideUpdateStream,
      TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if ( transitionGoal == TransitionGoal.open){
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;

      duration = new Duration(
        milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round()
      );

    } else {
      endSlidePercent = 0.0;
      duration = new Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round()
      );
    }
    //Crea la animación
    completionAnimationController = new AnimationController(
        duration: duration,
        vsync: vsync
    )
    //al recibir un tick, hace la siguientes acciones:
    ..addListener((){
      //modifica el porcentaje de visibilidad de la página
       slidePercent = lerpDouble(
          startSlidePercent,
          endSlidePercent,
          completionAnimationController.value
      );
      //pone un dato en el stream, inidicando que está "animating"
      slideUpdateStream.add(
        new SlideUpdate(
        UpdateType.animating,
        slideDirection,
        slidePercent,
        )
      );

    })

    ..addStatusListener((AnimationStatus status){
      //si terminó de animar, pone un dato en el stream indicando que "doneAnimating"
      if(status == AnimationStatus.completed){
        slideUpdateStream.add(
        new SlideUpdate(
          UpdateType.doneAnimating,
          slideDirection,
          endSlidePercent,
          )
        );
      }

    });

  }
  //ejecuta la animación
  run(){
    completionAnimationController.forward(from: 0.0);
  }
  //al terminar desturye la animación
  dispose(){
    completionAnimationController.dispose();
  }

}
//detalle del dato que necesita la clase anterior.
enum TransitionGoal{
  open,
  close,
}
//detalle del subdato SlideUpdate que se va a enviar por el Stream:
enum UpdateType{
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}
//dato a enviar por el Stream:
class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;

  SlideUpdate(
      this.updateType,
      this.direction,
      this.slidePercent
      );
}