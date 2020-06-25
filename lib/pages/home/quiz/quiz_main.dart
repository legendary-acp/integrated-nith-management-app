import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Questions()));
          },
        ),
      ],
    );
  }
}
