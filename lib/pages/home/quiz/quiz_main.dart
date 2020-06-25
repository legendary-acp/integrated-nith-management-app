import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions_manager.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  _openQuiz(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final manager = QuestionManager(database: database);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Questions(
        manager: manager,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          child: Text('Quiz'),
        ),
        IconButton(
          icon: Icon(Icons.chat),
          onPressed: () => _openQuiz(context),
        ),
      ],
    );
  }
}
