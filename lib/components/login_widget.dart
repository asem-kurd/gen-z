import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/grawer__list.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isVisible;
  final Function() toggleVisibility;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isVisible = false,
    required this.toggleVisibility,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.06),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: isPassword && !isVisible, // إخفاء النص إذا كانت كلمة السر
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFF474448),
              fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: toggleVisibility, // تغيير حالة الرؤية
                )
              : null,
        ),
      ),
    );
  }
}
