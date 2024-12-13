import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:flutter_application_99/view_model/user_model.dart';

class FirestoreOrg {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Orgnaization');

  Future<void> addUserToFireStore(Firestoreorg OrgModel) async {
    return await _userCollectionRef.doc(OrgModel.userid).set(OrgModel.toJson());
  }
}
