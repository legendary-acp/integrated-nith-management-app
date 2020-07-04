import 'package:flutter/material.dart';

class Quiz {
  Quiz({
    @required this.id,
    @required this.title,
    @required this.expireOn,
    @required this.teacher,
    @required this.timeLimit,
  });
  final String id;
  final String title;
  final DateTime expireOn;
  final String teacher;
  final int timeLimit;

  factory Quiz.fromMap({Map<String, dynamic> value, String id}) {
    return Quiz(
      id: id,
      title: value['title'],
      expireOn: value['expireOn'],
      teacher: value['teacher'],
      timeLimit: value['timeLimit'],
    );
  }
}
