import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final ballX;
  final ballY;

  MyBall(this.ballX, this.ballY);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX,ballY),
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown,
        ),
      ),
    );
  }
}
