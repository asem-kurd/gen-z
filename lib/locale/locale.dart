import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          '1': 'Settings',
          '2': 'Save',
          '3': 'Name',
          '4': 'Age',
          '5': 'Email',
          '6': 'Change Language',
          '7': 'Dark Mode',
        },
        'ar': {
          '1': 'الإعدادات',
          '2': 'حفظ',
          '3': 'الاسم',
          '4': 'العمر',
          '5': 'البريد الإلكتروني',
          '6': 'تغيير اللغة',
          '7': 'الوضع الداكن',
        },
      };
}