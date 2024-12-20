import 'package:flutter/cupertino.dart';
import 'package:flutter_application_99/main.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController {
  Locale initLanguage = sharepref!.getString("Language") == null
      ? Get.deviceLocale!
      : Locale(sharepref!.getString("Language")!);

  void changeLanguage(String codeLanguage) {
    Locale locale = Locale(codeLanguage);
    sharepref!.setString("Language", codeLanguage);
    Get.updateLocale(locale);
  }
}