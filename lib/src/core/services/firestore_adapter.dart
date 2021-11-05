import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreAdapter<T> {
  T fromFirestore(DocumentSnapshot<Map<String, dynamic>> document,
      SnapshotOptions? options);
  Map<String, Object?> toFirestore(T model, SetOptions? options);
}
