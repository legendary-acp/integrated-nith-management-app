import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Event {
  Event({
    this.id,
    @required this.title,
    @required this.description,
    @required this.startTime,
    @required this.date,
    this.urgent = false,
    this.done = false,
    @required this.type,
    this.endTime,
  }) {
    this.id = this.id ?? Uuid().v4();
  }

  String id;
  String title;
  String description;
  bool urgent;
  String type;
  TimeOfDay startTime;
  bool done;
  TimeOfDay endTime;
  String date;

  String get startEnd {
    String _startHour = this.startTime.hour.toString().padLeft(2, '0');
    String _startMin = this.startTime.minute.toString().padLeft(2, '0');
    if (this.endTime != null) {
      String _endHour = this.endTime.hour.toString().padLeft(2, '0');
      String _endMin = this.endTime.minute.toString().padLeft(2, '0');
      return _startHour + ':' + _startMin + '-' + _endHour + ':' + _endMin;
    } else {
      return _startHour + ':' + _startMin;
    }
  }

  factory Event.fromMap({Map<dynamic, dynamic> value, String id}) {
    return Event(
      id: id,
      title: value['title'],
      description: value['description'],
      type: value['type'],
      urgent: value['urgent'],
      done: value['done'],
      startTime: value['startTime'],
      endTime: value['endTime'],
      date: value['date'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'done': this.done,
      'urgent': this.urgent,
      'type': this.type,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'date': this.date,
    };
  }
}
