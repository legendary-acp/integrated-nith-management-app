import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key key,
      @required this.radius,
      @required this.option,
      @required this.isSelected})
      : super(key: key);

  final double radius;
  final String option;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: isSelected ? Colors.deepOrange : Colors.grey,
      ),
      child: Center(
        child: Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.75,
          ),
        ),
      ),
    );
  }
}
