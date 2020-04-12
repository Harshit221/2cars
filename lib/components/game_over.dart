import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gametest/game_controller.dart';

class GameOver {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  GameOver(this.gameController) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.text = TextSpan(
        text: 'GameOver',
        style: TextStyle(color: Colors.white, fontSize: 40.0));
    painter.layout();
    position = Offset(gameController.screenSize.width / 2 - painter.width / 2,
        gameController.screenSize.height * 0.2 - painter.height / 2);
    painter.paint(canvas, position);
  }
}
