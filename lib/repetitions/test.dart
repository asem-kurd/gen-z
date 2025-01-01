import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomSnackBar {
  // دالة لعرض الـ SnackBar مع النجاح واختفائه بعد ثانيتين
  static void showSuccessSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success!',
        message: 'Successfully logged into your account.',
        contentType: ContentType.success,
      ),
      duration:
          Duration(seconds: 2), // جعل الـ SnackBar يختفي بعد 2 ثانية
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // دالة لعرض الـ SnackBar مع رسالة خطأ واختفائه بعد ثانيتين
  static void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
      duration:
          const Duration(seconds: 2), // جعل الـ SnackBar يختفي بعد 2 ثانية
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
