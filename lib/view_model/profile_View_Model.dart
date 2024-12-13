import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  final localStorageData = Get.find();
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut(); //تسحيل خروج من اليوزر
    localStorageData.deleteUser();
  }
}
