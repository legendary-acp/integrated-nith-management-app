import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Subject {
  Subject({
    @required this.code,
    @required this.name,
    @required this.total,
    this.attendance,
  }) {
    this.barColor = charts.ColorUtil.fromDartColor(Colors.deepPurple);
  }

  final String code;
  final String name;
  final int total;
  final int attendance;
  charts.Color barColor;

  factory Subject.fromMap({Map<String, dynamic> value, String id}) {
    final Subject userDetail = Subject(
      code: id,
      name: value['name'],
      total: value['total'],
      attendance: value['attendance'],
    );
    return userDetail;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'code': this.code,
        'name': this.name,
        'total': this.total,
        'attendance': this.attendance,
      };
}
