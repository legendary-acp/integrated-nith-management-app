import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  Future<void> updateData(
      {@required String path, @required Map<dynamic, dynamic> data}) async {
    final documentReference = Firestore.instance.document(path);
    await documentReference.updateData(data);
    print('$path: $data');
  }

  Future<void> setData(
      {@required String path, @required Map<dynamic, dynamic> data}) async {
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(data);
    print('$path: $data');
  }

  Future<void> deleteData({@required String path}) async {
    final documentReference = Firestore.instance.document(path);
    await documentReference.delete();
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<dynamic, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }

  Stream<List<T>> collectionStream<T>(
      {@required String path,
      @required T builder(Map<dynamic, dynamic> data, String documentID),
      Query queryBuilder(Query query),
      int sort(T lhs, T rhs)}) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
