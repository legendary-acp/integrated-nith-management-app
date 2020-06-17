import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class EventManager {
  EventManager({@required this.database});

  final Database database;

  Future<List<Event>> getAllEventsByDate(String date) async {
    List requiredEvents;
    // FIXME: Error is in this line
    requiredEvents = await database.eventStream(date: date).toList();
    return requiredEvents;
  }

  Future<void> addEvent(Event event) async {
    await database.setEvent(data: event);
  }

  Future<void> deleteEvent(Event event) async {
    await database.deleteEvent(data: event);
  }

  Future<List> getAllUrgentEvent() async {
    // TODO: Implement function to get all urgent events which are not done
    return [];
  }

  Future<void> markEventAsDone(Event event) async {
    event.done = true;
    database.updateEvent(data: event);
  }
}
