import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:flutter/cupertino.dart';
import 'package:gametest/components/highscore.dart';
import 'package:gametest/components/obstacle.dart';
import 'package:gametest/components/start_button.dart';
import 'package:gametest/obstacle_spawner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/car.dart';
import 'components/game_over.dart';
import 'components/score.dart';

class GameController extends BaseGame {
  Size screenSize;
  double tileSize;
  Image image;
  var redCarImage;
  var blueCarImage;
  Car redCar;
  Car blueCar;
  Random random;
  int leftSide = 0;
  int rightSide = 0;
  bool gameOver = false;
  GameOver over;
  List<Obstacle> obstacles;
  ObstacleSpawner obstacleSpawner;
  StartButton startButton;
  int score;
  Score currentScore;
  SharedPreferences storage;
  HighScore highScore;


  GameController(this.storage) {
    start();
  }
  void start() async {
    screenSize = await Flame.util.initialDimensions();
    initiate();
  }

  void initiate() async {

    score = 0;
    tileSize = screenSize.width / 10;
    redCarImage = await Flame.images.load('redCar.png');
    blueCarImage = await Flame.images.load('blueCar.png');
    redCar = Car(this, redCarImage, 0);
    blueCar = Car(this, blueCarImage, 2 * tileSize);
    random = Random();
    over = GameOver(this);
    obstacles = List<Obstacle>();
    obstacleSpawner = ObstacleSpawner(this);
    startButton = StartButton(this);
    currentScore = Score(this);
    highScore = HighScore(this);


//    obstacles.add(Obstacle(this,Side.red));
//    obstacles.add(Obstacle(this,Side.blue));
  }

  void render(Canvas canvas) {
    if(!gameOver) {
      Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
      Paint backgroundPaint = Paint()..color = Color(0xff0f1849);
      canvas.drawRect(background, backgroundPaint);
      double width = screenSize.width;
      double height = screenSize.height;
      Paint paint = Paint()..color = Color(0xff4f5eb0);
      canvas.drawLine(
          Offset(width / 2 - 1, 0), Offset(width / 2 - 1, height), paint);
      canvas.drawLine(Offset(width / 2, 0), Offset(width / 2, height), paint);
      canvas.drawLine(
          Offset(width / 2 + 1, 0), Offset(width / 2 + 1, height), paint);
      canvas.drawLine(Offset(width / 4, 0), Offset(width / 4, height), paint);
      canvas.drawLine(
          Offset(3 * width / 4, 0), Offset(3 * width / 4, height), paint);
      if (redCar != null) {
        redCar.render(canvas);
      }
      if (blueCar != null) {
        blueCar.render(canvas);
      }

      obstacles.removeWhere((Obstacle obstacle) => !(obstacle.alive));
      obstacles.forEach((Obstacle obstacle){obstacle.render(canvas);});

    } else {
      over.render(canvas);
      startButton.render(canvas);
      highScore.render(canvas);
    }
    currentScore.render(canvas);

  }

  @override
  void update(double t) {
    if(!gameOver) {
      currentScore.update(t);
      if(obstacles != null)
        obstacles.forEach((Obstacle obstacle){obstacle.update(t);});
      obstacleSpawner.update(t);
    } else {
      startButton.update(t);
      highScore.update(t);
    }

  }

  // ignore: must_call_super
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 4;
  }

  void onTapDown(TapDownDetails details) {
    if(gameOver) {
      print('Game Over and tapped');
//      score = 0;
      obstacles = List<Obstacle>();
      obstacleSpawner = ObstacleSpawner(this);
      gameOver = false;
//      initiate();
    }
    else
      handleTap(details.globalPosition.dx);
  }

  void handleTap(double dx) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (dx < screenSize.width / 2) {
      if (currentTime - leftSide >= 50) {
        redCar.changePosition();
        leftSide = currentTime;
      }
    } else {
      if (currentTime - rightSide >= 50) {
        blueCar.changePosition();
        rightSide = currentTime;
      }
    }
  }

}
