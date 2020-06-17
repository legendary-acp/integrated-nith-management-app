import 'dart:async';

import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/services/api_path.dart';
import 'package:integratednithmanagementapp/services/firestore_service.dart';

abstract class Database {
  Future<void> setEvent({Event data});

  Future<void> deleteEvent({Event data});

  Future<void> updateEvent({Event data});

  Future<void> updateUserInfo({UserDetails info});

  Stream<UserDetails> getUserInfo();

  Stream<List<Event>> eventStream({String date});

  Stream<List<Event>> urgentEventStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> updateUserInfo({UserDetails info}) async => _service.updateData(
        path: APIPath.setUserInfo(uid: uid),
        data: info.toMap(),
      );

  @override
  Future<void> setEvent({Event data}) async => _service.setData(
        path: APIPath.event(uid: uid, eventId: data.id),
        data: data.toMap(),
      );

  @override
  Future<void> deleteEvent({Event data}) async => _service.deleteData(
        path: APIPath.event(uid: uid, eventId: data.id),
      );

  @override
  Future<void> updateEvent({Event data}) => _service.updateData(
      path: APIPath.event(uid: uid, eventId: data.id), data: data.toMap());

  @override
  Stream<UserDetails> getUserInfo() => _service.documentStream(
        path: APIPath.getUserInfo(uid: uid),
        builder: (data, documentId) =>
            UserDetails.fromMap(value: data, id: documentId),
      );
  @override
  Stream<List<Event>> eventStream({String date}) => _service.collectionStream(
        path: APIPath.events(uid: uid),
        queryBuilder: (query) => query.where('date', isEqualTo: date),
        builder: (data, documentID) =>
            Event.fromMap(value: data, id: documentID),
        sort: (lhs, rhs) => lhs.startTime.compareTo(rhs.startTime),
      );

  @override
  Stream<List<Event>> urgentEventStream() => _service.collectionStream(
        path: APIPath.events(uid: uid),
        queryBuilder: (query) => query.where('urgent', isEqualTo: true),
        builder: (data, documentID) =>
            Event.fromMap(value: data, id: documentID),
        sort: (lhs, rhs) => lhs.startTime.compareTo(rhs.startTime),
      );
}
