import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController {
  SharedPreferences? sharepref; // Make it nullable
  late Locale initLanguage;

  @override
  void onInit() {
    super.onInit();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    try {
      sharepref = await SharedPreferences.getInstance(); // Initialize sharepref
      String? savedLanguage = sharepref?.getString("language");

      // Set the initial language
      initLanguage = Locale(savedLanguage!);
    
      // Update the app's locale
      Get.updateLocale(initLanguage);
    } catch (e) {
      debugPrint('Error initializing preferences: $e');
      // Fallback to default locale if initialization fails
      initLanguage = const Locale('en');
      Get.updateLocale(initLanguage);
    }
  }

  void changeLanguage(String codeLanguage) {
    if (sharepref == null) {
      debugPrint('SharedPreferences is not initialized.');
      return;
    }

    Locale locale = Locale(codeLanguage);
    sharepref?.setString("language", codeLanguage);
    Get.updateLocale(locale);
  }
}