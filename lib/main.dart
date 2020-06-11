import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/pages/home/home_page.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

import 'package:integratednithmanagementapp/services/auth.dart';
import 'package:integratednithmanagementapp/pages/sign_in/signin.dart';

void main() => runApp(
      Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LandingDecider(),
        ),
      ),
    );

// Landing page decider Widget
class LandingDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignIn.create(context);
          } else {
            return Provider<User>.value(
              value: user,
              child: Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                child: HomePage(),
              ),
            );
          }
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
