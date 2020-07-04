import 'package:flutter/material.dart';

class Question {
  Question({
    @required this.id,
    @required this.title,
    @required this.optionA,
    @required this.optionB,
    @required this.optionC,
    @required this.optionD,
    @required this.correct,
    @required this.points,
  });
  final String id;
  final String title;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correct;
  final int points;

  factory Question.fromMap({Map<String, dynamic> value, String id}) {
    return Question(
      id: id,
      title: value['title'],
      optionA: value['optionA'],
      optionB: value['optionB'],
      optionC: value['optionC'],
      optionD: value['optionD'],
      correct: value['correct'],
      points: value['points'],
    );
  }
}
