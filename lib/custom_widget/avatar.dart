import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({
    @required this.radius,
    this.photoUrl,
  });

  final double radius;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          blurRadius: 20.0,
        ),
      ]),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: photoUrl != null
            ? NetworkImage(photoUrl)
            : AssetImage('assets/img/default_avatar.jpg'),
      ),
    );
  }
}
