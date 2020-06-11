import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/services/api_path.dart';
import 'package:integratednithmanagementapp/services/firestore_service.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';

abstract class Database {
  Future<void> setEvent({Event data});

  Stream<List<Event>> eventStream({String date});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> setEvent({Event data}) async =>
      _service.setData(
        path: APIPath.event(uid: uid, eventId: data.id),
        data: data.toMap(),
      );

  @override
  Stream<List<Event>> eventStream({String date}) =>
      _service.collectionStream(
          path: APIPath.events(uid: uid),
          queryBuilder: (query) => query.where('date', isEqualTo: date),
          builder: (data, documentID) =>
              Event.fromMap(value: data, id: documentID)
  );
}