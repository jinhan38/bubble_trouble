import 'dart:async';
import 'dart:math';

import 'package:bubble_trouble/ball.dart';
import 'package:bubble_trouble/button.dart';
import 'package:bubble_trouble/missile.dart';
import 'package:bubble_trouble/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // player variable
  static double playerX = 0;
  double missileX = playerX;
  double missileHeight = 10;
  bool midShot = false;
  double ballX = 0.5;
  double ballY = 1;
  double velocity = 60;
  var ballDirection = direction.LEFT;

  startGame() {
    double time = 0;
    double height = 0;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // height = (-5 * time * time) + 60 * time;
      height = (-5 * time * time) + velocity * time;
      setState(() {
        ballY = heightToPosition(height);
      });
      if (height < 0) {
        time = 0;
      }
      time += 0.1;
      if (ballX - 0.005 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.005 > 1) {
        ballDirection = direction.LEFT;
      }
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.005;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.005;
        });
      }

      if (playerDies()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  _showDialog() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.grey,
        title: Text("You dead", style: TextStyle(color: Colors.white),),
      );
    });
  }

  moveLeft() {
    setState(() {
      if (playerX - 0.1 >= -1) {
        playerX -= 0.1;
      }
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  moveRight() {
    setState(() {
      if (playerX + 0.1 <= 1) {
        playerX += 0.1;
      }
      missileX = playerX;
    });
  }

  fireMissile() {
    if (!midShot) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        midShot = true;
        setState(() {
          missileHeight += 10;
        });

        if (missileHeight > MediaQuery
            .of(context)
            .size
            .height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }

        if (ballY > heightToPosition(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          // ballY = 5;
          ballX = 3;
          timer.cancel();
        }
      });
    }
  }

  double heightToPosition(double height) {
    double totalHeight = MediaQuery
        .of(context)
        .size
        .height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  resetMissile() {
    missileX = playerX;
    missileHeight = 10;
    midShot = false;
  }

  bool playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissile();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink.shade200,
              child: Stack(
                children: [
                  MyBall(ballX, ballY),
                  MyMissile(missileX: missileX, missileHeight: missileHeight),
                  MyPlayer(playerX: playerX),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    icon: const Icon(Icons.play_arrow),
                    function: startGame,
                  ),
                  MyButton(
                    icon: const Icon(Icons.arrow_back),
                    function: moveLeft,
                  ),
                  MyButton(
                    icon: const Icon(Icons.arrow_upward),
                    function: fireMissile,
                  ),
                  MyButton(
                    icon: const Icon(Icons.arrow_forward),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
