import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Subject {
  Subject({
    @required this.code,
    @required this.name,
    @required this.total,
    @required this.barColor,
    this.attendance = 0,
  });

  final String code;
  final String name;
  final int total;
  final int attendance;
  final charts.Color barColor;
}
