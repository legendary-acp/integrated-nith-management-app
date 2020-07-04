import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_button.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_radio_button.dart';
import 'package:integratednithmanagementapp/model/question_model.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/questions_manager.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({@required this.manager});

  final QuestionManager manager;

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool select = false;
  bool isLoaded = false;

  int index = 0;
  int noOfQues = 1;

  Widget _buildOption({String option, String statement}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          select = !select;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              MediaQuery.of(context).size.height * 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CustomRadioButton(
                radius: MediaQuery.of(context).size.height * 0.05,
                isSelected: select,
                option: option,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                child: Text(
                  statement,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(Question ques) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // MAX characters 120
                ques.title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildOption(
                option: 'A',
                statement: ques.optionA,
              ),
              _buildOption(
                option: 'B',
                statement: ques.optionB,
              ),
              _buildOption(
                option: 'C',
                statement: ques.optionC,
              ),
              _buildOption(
                option: 'D',
                statement: ques.optionD,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }

  Widget _buildScreen(AsyncSnapshot snapshot) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'QUIZ TITLE',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF17242D)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  '1/10',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2d2017),
                  ),
                ),
                Text(
                  'Questions',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA6CDDA),
                  ),
                )
              ],
            ),
            CircularCountDownTimer(
              height: (MediaQuery.of(context).size.height * 0.15),
              width: (MediaQuery.of(context).size.height * 0.15),
              duration: 100,
              onComplete: () {
                //Navigator.pop(context);
              },
              color: Colors.grey,
              fillColor: Colors.green,
            ),
            Column(
              children: <Widget>[
                Text(
                  '10',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF2d2017),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Points',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA6CDDA),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Container(
          child: _buildQuestion(snapshot.data[index]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Question>>(
          stream: widget.manager.question,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              noOfQues = snapshot.data.length;
              return Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFF17242D),
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height / 3),
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image(
                        image: AssetImage('assets/img/background.png'),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  _buildScreen(snapshot),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          index == 0
                              ? Container()
                              : IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      index--;
                                    });
                                  },
                                ),
                          index == noOfQues - 1
                              ? CustomButton(
                                  text: 'Submit',
                                  textColor: Colors.black,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 35,
                                  pressed: () {
                                    setState(() {});
                                  },
                                )
                              : Container(),
                          index < noOfQues - 1
                              ? IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      index++;
                                    });
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Align(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
