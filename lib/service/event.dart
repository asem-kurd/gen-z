import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';

class firestoreEvent {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Events');

  Future<void> addUserToFireStore(EventModel eventmodel) async {
    return await _userCollectionRef
        .doc(eventmodel.userId)
        .set(eventmodel.toJson());
  }
}
