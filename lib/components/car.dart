import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:gametest/game_controller.dart';
import 'dart:ui';

class Car extends SpriteComponent{
  final GameController gameController;
  int scale ;
  double position;
  bool tapped = false;
  Car(this.gameController, Image image, this.position){
    this.sprite = Sprite.fromImage(image);
    this.scale = 0;
    position += gameController.tileSize / 2 - sprite.image.width / 2;


  }
  void render(Canvas canvas) {
    if(!tapped) {
      sprite.renderPosition(canvas, Position(position + scale * gameController.tileSize, gameController.screenSize.height * 0.70));
    }
    else {
      tapped = false;

    }
  }
  void changePosition() {
    tapped = true;
    scale = (scale + 1) % 2;
  }
}