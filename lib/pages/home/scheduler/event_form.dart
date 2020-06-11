import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_manager.dart';

class EventForm {
  EventForm({@required this.manager});

  final EventManager manager;

  String title = '';
  String description = '';
  bool urgent = false;
  String type = '';
  TimeOfDay startTime;
  TimeOfDay endTime;
  String date = '';

  List eventTypes = [
    'Class',
    'HomeWork',
    'Shopping',
  ];

  void updateEventDetails(
      {String title, String description, bool urgent, String type}) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.type = type ?? this.type;
    this.urgent = urgent ?? this.urgent;
  }

  void updateStartTime(DateTime dateTime) {
    this.startTime = TimeOfDay.fromDateTime(dateTime);
  }

  void updateEndTime(DateTime dateTime) {
    this.endTime = TimeOfDay.fromDateTime(dateTime);
  }

  void updateDate(DateTime dateTime) {
    this.date = _date(dateTime);
  }

  String _date(DateTime dateTime) {
    String date = dateTime.toIso8601String().substring(0, 10);
    return date;
  }

  Future<void> submit(BuildContext context) async {
    Event event = Event(
      title: this.title,
      description: this.description,
      startTime: this.startTime,
      date: this.date,
      type: this.type,
      urgent: this.urgent ?? false,
      endTime: this.endTime ?? null,
    );
    await manager.addEvent(event);
    Navigator.pop(context);
  }
}
