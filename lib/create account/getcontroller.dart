import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegistrationController extends GetxController {
  // Gender selection and form fields
  var selectedGender = 'Male'.obs;
  var selectedCity = 'Amman'.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Password visibility states
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // List of cities in Jordan
  final cities = [
    'Amman',
    'Irbid',
    'Zarqa',
    'Madaba',
    'Mafraq',
    'Aqaba',
    'Karak',
    'Tafila',
    'Ma\'an',
    'Ajloun',
    'Jerash',
    'Balqa'
  ];
}
