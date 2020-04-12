import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gametest/components/side.dart';
import 'package:gametest/game_controller.dart';

abstract class Obstacle {
  final GameController gameController;
  double speed;
  Side side;
  int scale;

  double fromLeft;
  bool alive = true;
  double fromUp;

  Obstacle(this.gameController, this.side) {
    scale = gameController.random.nextInt(100)%2;
    speed = gameController.tileSize * 2.5;
//    scale = 1;
    fromLeft = scale * gameController.tileSize + (side == Side.red ? 0 : 2 * gameController.tileSize) + gameController.tileSize / 2 - gameController.blueCar.sprite.image.width.toDouble() / 2;
    fromUp = -50;

  }
  void render(Canvas canvas);

  void update(double t);

}