import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  DataField({@required this.entryName, @required this.entryValue});
  
  final String entryName;
  final String entryValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
            entryName,
          style: TextStyle(
            fontFamily: 'b612',
            color: Colors.blueGrey,
            fontSize: 16.0,

          ),
        ),
        Text(
            entryValue,
          style: TextStyle(
            fontFamily: 'b612',
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
