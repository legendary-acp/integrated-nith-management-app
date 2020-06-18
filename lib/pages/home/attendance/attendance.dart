import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/subject_model.dart';
import 'package:integratednithmanagementapp/pages/home/attendance/attendace_chart.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<Subject> subjects = [
    Subject(
      code: 'CSD-320',
      name: 'CN',
      attendance: 8,
      total: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.deepPurple),
    ),
    Subject(
      code: 'CSD-321',
      name: 'DIP',
      attendance: 7,
      total: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    Subject(
      code: 'CSD-320',
      name: 'CN1',
      attendance: 8,
      total: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.deepPurple),
    ),
    Subject(
      code: 'CSD-322',
      name: 'ADBMS',
      attendance: 2,
      total: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    Subject(
      code: 'CSD-320',
      name: 'CN2',
      attendance: 8,
      total: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.deepPurple),
    ),
  ];

  List<Widget> children = List<Widget>();

  Widget _buildDetailsCard({int attendance, int total, String name}) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.47),
      height: (MediaQuery.of(context).size.height * 0.125),
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'libre_baskerville',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height * 0.001),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$attendance/$total',
                  style: TextStyle(
                    fontFamily: 'libre_baskerville',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    for (int i = 0; i < subjects.length; i++) {
      child = _buildDetailsCard(
        attendance: subjects[i].attendance,
        total: subjects[i].total,
        name: subjects[i].name,
      );
      children.add(child);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: (MediaQuery.of(context).size.height / 20)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Attendance',
            style: TextStyle(
              fontFamily: 'libre_baskerville',
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: AttendanceChart(
            subjects: subjects,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Text(
            'Details',
            style: TextStyle(
              fontFamily: 'libre_baskerville',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.height * 0.365),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Wrap(
                  children: children,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
