import 'package:flutter/material.dart';

class QuizModel {
  QuizModel({
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

  factory QuizModel.fromMap({Map<String, dynamic> value, String id}) {
    return QuizModel(
      id: id,
      title: value['title'],
      expireOn: value['expireOn'],
      teacher: value['teacher'],
      timeLimit: value['timeLimit'],
    );
  }
}
