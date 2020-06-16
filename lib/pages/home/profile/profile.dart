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
    return Stack(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
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
          ),
          Center(
            child: ProfileAvatar(
              photoUrl: user.photoURL,
              radius: 60.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: (MediaQuery.of(context).size.height-375),
            padding: EdgeInsets.only(left: 20),
            child: ListView(
              children: <Widget>[
                DataField(
                  entryName: 'Name',
                  entryValue: user.displayName != '' ? user.displayName : 'N/A',
                  edit: (){print(user.displayName);},
                ),
                Divider(
                  thickness: 1,
                ),
                DataField(
                  entryName: 'Email',
                  entryValue: user.email != '' ? user.email : 'N/A',
                  edit: (){print("Pressed");},
                ),
                Divider(
                  thickness: 1,
                ),
                DataField(
                  entryName: 'Phone Number',
                  entryValue: user.phoneNumber != '' ? user.phoneNumber : 'N/A',
                  edit: (){print("Pressed");},
                )
              ],
            ),
          ),
        ],
      ),
      CustomIconButton(
        top: 200,
        left: (MediaQuery.of(context).size.width / 2 ),
        bgColor: Colors.indigo,
        iconColor: Colors.white,
        size: 25.0,
        onPress: _changeProfilePic,
      ),
    ]);
  }

  _changeProfilePic() {
    //TODO: Implement update profile pic feature
  }
}
