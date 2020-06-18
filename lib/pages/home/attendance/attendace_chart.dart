import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/subject_model.dart';

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({Key key, this.subjects}) : super(key: key);

  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Subject, String>> series = [
      charts.Series(
        id: 'Attendance',
        data: subjects,
        domainFn: (Subject sub, _) => sub.name,
        measureFn: (Subject sub, _) => (sub.attendance / sub.total * 100),
        colorFn: (Subject sub, _) => sub.barColor,
      )
    ];

    return Container(
      height: (MediaQuery.of(context).size.height / 3),
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: charts.BarChart(
            series,
            animate: true,
          ),
        ),
      ),
    );
  }
}
