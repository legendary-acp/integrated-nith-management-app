import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/question_model.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class QuestionManager {
  QuestionManager({@required this.database});
  final Database database;

  // Todo: Function to get question from database
  Future<QuestionModel> getQuestion() async {
    return QuestionModel(
      id: 'uiz',
      title: 'This is Question',
      optionA: 'A',
      optionB: 'B',
      optionC: 'C',
      optionD: 'D',
      correct: 'optionA',
      points: 10,
    );
  }
}
