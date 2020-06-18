import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/custom_widget/avatar.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_icon_button.dart';
import 'package:integratednithmanagementapp/custom_widget/data_field.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/pages/home/profile/Dialogs.dart';
import 'package:integratednithmanagementapp/services/auth.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _buildDetailFields({UserDetails details, Database database}) {
    Dialogs dialogs =
        Dialogs(context: context, details: details, database: database);
    return ListView(
      children: <Widget>[
        DataField(
          entryName: 'Name',
          entryValue: details.displayName,
          edit: () {
            dialogs.showDisplayNameDialog();
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Roll No',
          entryValue: details.rollNo,
          edit: () {
            dialogs.showRollNoDialog();
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Email',
          entryValue: details.email,
          isEmail: true,
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Mobile No.',
          entryValue: details.mobileNo,
          edit: () {
            dialogs.showMobileNoDialog();
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Branch',
          entryValue: details.branch,
          edit: () {
            dialogs.showBranchDialog();
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Year',
          entryValue: details.year,
          edit: () {
            dialogs.showYearDialog();
          },
        ),
        Divider(
          thickness: 1,
        ),
        DataField(
          entryName: 'Hostel',
          entryValue: details.hostel,
          edit: () {
            dialogs.showHostelDialog();
          },
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context, String uid) {
    Database database = Provider.of<Database>(context);
    return StreamBuilder(
        stream: database.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            UserDetails _details = snapshot.data ?? UserDetails(uid: uid);
            return _buildDetailFields(details: _details, database: database);
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
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: (MediaQuery.of(context).size.height / 20)),
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
                radius: (MediaQuery.of(context).size.height / 12),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 20),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * 0.53),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20),
              child: _buildDetails(context, user.uid),
            ),
          ],
        ),
      ),
      CustomIconButton(
        top: (MediaQuery.of(context).size.height * 0.29),
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
