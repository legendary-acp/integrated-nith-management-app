import 'package:flutter/cupertino.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class EventManager {
  EventManager({@required this.database});

  final Database database;

  Future<List> getAllEventsByDate(String date) async {
    // TODO: implement function to get list of all events of particular date
    return [];
  }

  Future<void> addEvent(Event event) async {
    // TODO: implement function to add event to database
    await database.setEvent(data: event);
    print('Data added');
  }

  Future<List> getAllUrgentEvent() async {
    // TODO: Implement function to get all urgent events which are not done
    return [];
  }

  Future<void> markEventAsDone(String uid) async {
    // TODO: Implement function to mark event as done
  }
}
