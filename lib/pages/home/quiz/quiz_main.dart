import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions_manager.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions_screen.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  _openQuiz(BuildContext context, String qid) {
    final database = Provider.of<Database>(context, listen: false);
    final manager = QuestionManager(database: database, qid: qid);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QuestionsScreen(
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
          onPressed: () => _openQuiz(context, 'HonoCAWjGcbiysDzLcog'),
        ),
      ],
    );
  }
}
