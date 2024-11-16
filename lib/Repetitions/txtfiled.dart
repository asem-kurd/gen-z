import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Txtfiled extends StatelessWidget {
  final String label;
  final Size size;
  final String text;
  final bool pass;

  const Txtfiled({
    super.key,
    this.label = "Email",
    this.size = const Size(200, 50),
    this.text = "Please enter your first name",
    this.pass = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          
        ),
        obscureText: pass,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return text.isNotEmpty ? text : 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
