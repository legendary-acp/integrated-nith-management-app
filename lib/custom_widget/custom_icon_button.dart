import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    @required this.bgColor,
    @required this.iconColor,
    @required this.top,
    @required this.left,
    @required this.size,
    @required this.onPress,
  });

  final Color iconColor;
  final Color bgColor;
  final double top;
  final double left;
  final double size;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: RawMaterialButton(
        onPressed: onPress,
        elevation: 2.0,
        fillColor: bgColor,
        child: Icon(
          Icons.camera_enhance,
          color: iconColor,
          size: size,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
