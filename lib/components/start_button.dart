import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../game_controller.dart';

class StartButton {
  final GameController gameController;
  TextPainter painter;
  Offset position;
  StartButton(this.gameController) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas canvas) {

    painter.paint(canvas, position);
  }

  void update(double t) {

    painter.text = TextSpan(
        text: 'Start',
        style: TextStyle(color: Colors.white, fontSize: 45.0));
    painter.layout();
    position = Offset(gameController.screenSize.width / 2 - painter.width / 2,
        gameController.screenSize.height * 0.5 - painter.height / 2);
  }
}