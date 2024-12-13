import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_99/view_model/user_model.dart';

class Firestoreuser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }
  Future<DocumentSnapshot>getCurrentUser(String uid)async=>await _userCollectionRef.doc(uid).get();
}
