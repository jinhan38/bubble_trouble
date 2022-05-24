

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
   MyPlayer({
     this.playerX,
     Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
