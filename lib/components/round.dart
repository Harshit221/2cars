import 'package:flutter/material.dart';
import 'package:gametest/components/obstacle.dart';
import 'package:gametest/components/side.dart';
import 'package:gametest/game_controller.dart';

class Round extends Obstacle {

  double radius;

  Round(GameController gameController, Side side) : super(gameController, side) {
    radius = gameController.tileSize * 0.22;
    fromLeft = scale * gameController.tileSize + (side == Side.red ? 0 : 2 * gameController.tileSize) + gameController.tileSize / 2 ;
  }


  void render(Canvas canvas) {

    Color color;
    if(side == Side.red) {
      color = Colors.red[400];
    } else {
      color = Colors.blueGrey;
    }
    Paint paint = Paint()..color = color;
    canvas.drawCircle(Offset(fromLeft, fromUp), radius, paint);
  }

  void update(double t) {
    if(alive) {
      fromUp  += speed * t;

      if(fromUp > gameController.screenSize.height + gameController.tileSize) {
        gameController.gameOver = true;
      }
      int carScale = (side == Side.red ? gameController.redCar.scale : gameController.blueCar.scale);
      if(fromUp + radius  >= gameController.screenSize.height * 0.7 && fromUp <= gameController.screenSize.height * 0.7 + gameController.redCar.sprite.image.height && carScale == scale) {
        alive = false;
        gameController.score++;
        if (gameController.score > (gameController.storage.getInt('highscore') ??
            0)) {
          gameController.storage.setInt('highscore', gameController.score);
          print(gameController.score);
        }
      }

    }
  }

}