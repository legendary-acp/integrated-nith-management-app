import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  LargeText(
      {@required this.text,
      this.color,
      this.paddingTop = 0.0,
      this.paddingLeft = 20,
      this.size = 40.0});

  final String text;
  final Color color;
  final double size;
  final double paddingTop;
  final double paddingLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop, left: paddingLeft),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color,
        ),
      ),
    );
  }
}
