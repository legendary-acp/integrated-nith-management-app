import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_button.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_radio_button.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool select = false;
  bool isLast = true;
  Widget _buildOption({String option, String statement}) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
            InkWell(
              onTap: () {
                setState(() {
                  select = !select;
                });
              },
              child: CustomRadioButton(
                radius: MediaQuery.of(context).size.height * 0.05,
                isSelected: select,
                option: option,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              statement,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              // Fixme: If possible increase size of container according to size of text
              // else limit question length
              'Question',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildOption(option: 'A', statement: 'Option A'),
              _buildOption(option: 'B', statement: 'Option B'),
              _buildOption(option: 'C', statement: 'Option C'),
              _buildOption(option: 'D', statement: 'Option D'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isLast = false;
                });
              },
            ),
            isLast
                ? CustomButton(
                    text: 'Submit',
                    textColor: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 35,
                    pressed: () {
                      setState(() {
                        isLast = true;
                      });
                    },
                  )
                : Container(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: isLast ? Colors.grey[800] : Colors.white,
              ),
              onPressed: isLast
                  ? () {}
                  : () {
                      print('object');
                      setState(() {
                        isLast = true;
                      });
                    },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScreen() {
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
              width: 60,
              child: FlatButton(
                child: Text(
                  'Skip',
                ),
                onPressed: () {},
              ),
            ),
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
          child: _buildQuestion(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          _buildScreen(),
        ],
      ),
    );
  }
}
