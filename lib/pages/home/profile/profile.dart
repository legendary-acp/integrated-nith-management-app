import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/custom_widget/avatar.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_icon_button.dart';
import 'package:integratednithmanagementapp/custom_widget/data_field.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/services/auth.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _buildDetailFields(UserDetails details) {
    return ListView(
      children: <Widget>[
        DataField(
          entryName: 'Name',
          entryValue: details.displayName,
          edit: () {
            print(details.displayName);
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Roll No',
          entryValue: details.rollNo,
          edit: () {
            print("Pressed");
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Email',
          entryValue: details.email,
          edit: () {
            print("Pressed");
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Phone Number',
          entryValue: details.mobileNo,
          edit: () {
            print("Pressed");
          },
        )
      ],
    );
  }

  Widget _buildDetails(BuildContext context, String uid) {
    Database database = Provider.of<Database>(context);
    return StreamBuilder(
        stream: database.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(snapshot.data);
            UserDetails _details = snapshot.data ?? UserDetails(uid: uid);
            return _buildDetailFields(_details);
          } else {
            return Align(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

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
            height: (MediaQuery.of(context).size.height - 375),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20),
            child: _buildDetails(context, user.uid),
          ),
        ],
      ),
      CustomIconButton(
        top: 200,
        left: (MediaQuery.of(context).size.width / 2),
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
