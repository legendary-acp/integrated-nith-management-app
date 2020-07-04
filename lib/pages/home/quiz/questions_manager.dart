import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class QuestionManager {
  QuestionManager({@required this.database, @required this.qid}) {
    question = database.quizQuestions(qid: qid);
  }
  final Database database;
  final String qid;

  Stream question;
}
