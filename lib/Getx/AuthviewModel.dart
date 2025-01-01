import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/Repetitions/test.dart';
import 'package:flutter_application_99/admin/admin.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/create%20account/org.dart';
import 'package:flutter_application_99/service/firestoreOrg.dart';
import 'package:flutter_application_99/service/firestoreuser.dart';
import 'package:flutter_application_99/view_model/user_model.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:flutter_application_99/widget_Org/control_home.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authviewmodel extends GetxController {
  // TextEditingControllers for input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  var isChecked = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String email, password, avatar, address, name;
  late String title, description, event_type, upload_image, gender;
  late Timestamp end_time, start_time;
  late int required_number;
  late GeoPoint latitude;
  late List<String> image_url;
  late double age, phone;
  late String url;

  Rx<User?> user = Rx<User?>(null);
  Rx<Org?> org = Rx<Org?>(null);

  String get userEmail => user.value?.email ?? 'No user logged in';

  // Sign up with email and password
  void signUpWithEmailAndPassword(BuildContext context) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Signup Error",
          "Please enter both email and password.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }

      // تحقق من صحة بيانات المستخدم
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CustomSnackBar.showSuccessSnackBar(context);

      // استعلام Firestore للتحقق من البريد الإلكتروني للمسؤول
      final admin = await firestore.collection('Admin').limit(1).get();

      // Navigate based on user role
      if (isChecked.value == true) {
        Get.offAll(const ControllHomeOrg());
      } else if (isChecked.value == false &&
          email != admin.docs.first['email']) {
        Get.offAll(const controll_home());
      } else if (email == admin.docs.first['email']) {
        Get.offAll(Admin());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An unexpected error occurred";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email. Please sign up.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage =
            "The email address is invalid. Please enter a valid email.";
      }

      Get.snackbar(
        "Signup Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Signup Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }

// Create user with email and password
  void createUserWithEmailAndPassword() async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty || phone == 0.0) {
        Get.snackbar(
          "Signup Error",
          "Please fill in all fields.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Firestoreuser().addUserToFireStore(UserModel(
        gender: gender,
        userId: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: name,
        age: age,
        password: password,
        phone: phone,
      ));
    } catch (e) {
      print(e);
      Get.snackbar(
        "Signup Error Create account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }

  // Create organization with email and password
  void createOrgWithEmailAndPassword() async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty || phone == 0.0) {
        Get.snackbar(
          "Signup Error",
          "Please fill in all fields.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }

      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (Org) async {
          await FirestoreOrg().addUserToFireStore(Firestoreorg(
            userid: Org.user!.uid,
            email: Org.user!.email!,
            name: name,
            password: password,
            phone: phone,
            url: url,
            address: "",
            role: "org",
          ));
        },
      );
      Get.offAll(CreateUser());
    } catch (e) {
      print(e);
      Get.snackbar(
        "Signup Error create account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }

  void resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "لم يتم العثور على مستخدم بهذا البريد الإلكتروني";
          break;
        default:
          errorMessage = "حدث خطأ: ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
