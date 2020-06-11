import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/custom_widget/avatar.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_icon_button.dart';
import 'package:integratednithmanagementapp/custom_widget/data_field.dart';
import 'package:provider/provider.dart';
import 'package:integratednithmanagementapp/services/auth.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    AuthBase auth = Provider.of<AuthBase>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'libre_baskerville',
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    iconSize: 30,
                    onPressed: () {
                      auth.signOut();
                    })
              ],
            ),
            SizedBox(height: 30),
            Center(
                child: ProfileAvatar(
              photoUrl: user.photoURL,
              radius: 60.0,
            )),
            SizedBox(
              height: 70.0,
            ),
            DataField(
              entryName: 'Name',
              entryValue: user.displayName != null ? user.displayName : 'User-${user.uid}',
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            DataField(
              entryName: 'Email',
              entryValue: user.email != null ? user.email : 'example@example.com',
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            DataField(
              entryName: 'Phone Number',
              entryValue:
                  user.phoneNumber != null ? user.phoneNumber : '+91-XXXXX-XXXXX',
            )
          ],
        ),
        CustomIconButton(
          top: 200,
          left: 175,
          bgColor: Colors.indigo,
          iconColor: Colors.white,
          size: 25.0,
          onPress: _onPress,
        ),
      ]),
    );
  }

  _onPress() {
    //TODO: Implement update profile pic feature
  }
}
