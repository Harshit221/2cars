

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';

class HighScore {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  HighScore(this.gameController) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
  }

  void update(double t) {
    int highScore = gameController.storage.getInt('highscore') ?? 0;
    if ((painter.text ?? '') != gameController.score.toString()) {
      painter.text = TextSpan(
          text: 'HighScore: $highScore',
          style: TextStyle(color: Colors.white, fontSize: 35.0));
      painter.layout();
      position = Offset(gameController.screenSize.width / 2 - painter.width / 2,
          gameController.screenSize.height * 0.75 - painter.height / 2);
    }
  }
}
