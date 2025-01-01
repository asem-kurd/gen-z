import 'package:flutter/material.dart';

class RegUserList extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final List<String>? items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const RegUserList({super.key, 
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.items = const [], // Default empty list
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
      child: items?.isEmpty ?? true
          ? TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(color: Color(0xFF474448)),
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFF474448),
                  fontStyle: FontStyle.italic,
                ),
                filled: true,
                fillColor: const Color(0xff908b92),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: validator,
              onSaved: onSaved,
            )
          : DropdownButtonFormField<String>(
              value: selectedValue ??
                  (items?.isEmpty ?? true ? null : items!.first),
              onChanged: onChanged,
              items: items!
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFF474448),
                  fontStyle: FontStyle.italic,
                ),
                filled: true,
                fillColor: const Color(0xff908b92),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: validator,
              onSaved: onSaved,
            ),
    );
  }
}
