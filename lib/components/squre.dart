import 'package:flutter/material.dart';
import 'package:gametest/components/obstacle.dart';
import 'package:gametest/components/side.dart';
import 'package:gametest/game_controller.dart';

class Square extends Obstacle {
  Square(GameController gameController, Side side) : super(gameController, side);
  Rect rect;
  void render(Canvas canvas) {

    Color color;
    if(side == Side.red) {
      color = Colors.red[400];
    } else {
      color = Colors.blueGrey;
    }
    Paint paint = Paint()..color = color;
    rect = Rect.fromLTWH(fromLeft, fromUp, gameController.blueCar.sprite.image.width.toDouble(), gameController.blueCar.sprite.image.width.toDouble());
    canvas.drawRect(rect, paint);

  }

  void update(double t) {
    if(alive) {
      fromUp  += speed * t;

      if(fromUp > gameController.screenSize.height + gameController.tileSize) {
        alive = false;
      }
      int carScale = (side == Side.red ? gameController.redCar.scale : gameController.blueCar.scale);
      if(fromUp + rect.height >= gameController.screenSize.height * 0.7 && fromUp<= gameController.screenSize.height * 0.7 + gameController.redCar.sprite.image.height && carScale == scale) {
        gameController.gameOver = true;
      }

    }
  }

}