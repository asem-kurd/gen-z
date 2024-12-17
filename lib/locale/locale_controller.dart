import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController {

  // Locale initLanguage =  

  void changeLanguage(String codeLanguage) {
    Locale locale = Locale(codeLanguage);
    Get.updateLocale(locale);
  }
}
