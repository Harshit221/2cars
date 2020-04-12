import 'package:gametest/components/obstacle.dart';
import 'package:gametest/game_controller.dart';

import 'components/round.dart';
import 'components/side.dart';
import 'components/squre.dart';

class ObstacleSpawner {
  final GameController gameController;
  int timeInterval;
  int currentLeft;
  int currentRight;
  ObstacleSpawner(this.gameController) {
    initialize();
  }
  void initialize() {
    gameController.score = 0;
    timeInterval = 1900;
    currentLeft = DateTime.now().millisecondsSinceEpoch + gameController.random.nextInt(2000);
    currentRight = currentLeft + gameController.random.nextInt(500) + 20;
  }
  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if(now >= currentLeft ) {
      Obstacle obstacle = gameController.random.nextInt(100)%2 == 0 ? Square(gameController,Side.red) : Round(gameController,Side.red);
      gameController.obstacles.add(obstacle);
      currentLeft += timeInterval;
    }
    if(now >= currentRight ) {
      Obstacle obstacle = gameController.random.nextInt(100)%2 == 0 ? Square(gameController,Side.blue) : Round(gameController,Side.blue);
      gameController.obstacles.add(obstacle);
      currentRight += timeInterval;
    }
  }
  void removeAll(){
    gameController.obstacles.forEach((Obstacle obs){
      obs.alive = false;
    });
  }
}