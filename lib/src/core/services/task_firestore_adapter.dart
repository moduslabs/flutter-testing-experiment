import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:logger/logger.dart';

import 'firestore_adapter.dart';

class TaskFirestoreAdapter implements FirestoreAdapter<Task> {
  final _logger = Logger();

  @override
  Task fromFirestore(DocumentSnapshot<Map<String, dynamic>> document, _) {
    _logger.i('Parsing firestore document ${document.id} to task');
    if (document.data() == null) {
      return Task.nullObject();
    }
    return Task.fromJson(document.id, document.data()!);
  }

  @override
  Map<String, Object?> toFirestore(Task model, _) {
    _logger.i('Parsing task ${model.id} to firestore document');
    return model.toJson();
  }
}