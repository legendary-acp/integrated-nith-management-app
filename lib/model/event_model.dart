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
  String startTime;
  bool done;
  String endTime;
  String date;

  String get startEnd {
    if (this.endTime != null) {
      return '$startTime-$endTime';
    } else {
      return startTime;
    }
  }

  factory Event.fromMap({Map<String, dynamic> value, String id}) {
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
