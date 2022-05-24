import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final icon;
  final function;

  MyButton({
    required this.icon,
    required this.function,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.grey.shade100,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
