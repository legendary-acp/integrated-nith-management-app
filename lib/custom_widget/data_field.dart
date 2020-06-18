import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  DataField(
      {@required this.entryName,
      @required this.entryValue,
      this.edit,
      this.isEmail = false});

  final String entryName;
  final String entryValue;
  Function edit = () {};
  bool isEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                entryValue,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'b612',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.right,
              ),
              isEmail
                  ? SizedBox(
                      width: 50,
                    )
                  : IconButton(
                      icon: Icon(Icons.border_color),
                      iconSize: 15,
                      onPressed: edit,
                    )
            ],
          )
        ],
      ),
    );
  }
}
