import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.pressed,
    this.bgColor = Colors.white,
    this.width = 250,
    this.height = 50.0,
    this.radius = 20.0,
    this.imageURL,
    this.elevation =10.0,
    this.text,
    this.heightImage,
    this.textColor = Colors.black,
  }) : super(key: key);

  final Function pressed;
  final String imageURL;
  final Color bgColor;
  final Color textColor;
  final String text;
  final double elevation;
  final double width;
  final double heightImage;
  final double height;
  final double radius;

  Widget textOnly() {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      imageURL,
      height: heightImage==null ? height :heightImage ,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: this.height,
      minWidth: this.width,
      child: RaisedButton(
        elevation: elevation,
        child: imageURL == null ? textOnly() : logo(),
        color: bgColor,
        onPressed: pressed,
        shape: imageURL == null ? RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(this.radius),
          ),
        ) : CircleBorder(),
      ),
    );
  }
}
