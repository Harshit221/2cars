import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';

class Score {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  Score(this.gameController) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
  }

  void update(double t) {
    if ((painter.text ?? '') != gameController.score.toString()) {
      painter.text = TextSpan(
          text: gameController.score.toString(),
          style: TextStyle(color: Colors.white, fontSize: 35.0));
      painter.layout();
      position = Offset(gameController.screenSize.width - painter.width * 2,
          painter.height);
    }
  }
}
