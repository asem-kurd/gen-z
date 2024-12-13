import 'package:flutter/material.dart';

class Textfiledsign extends StatelessWidget {
  final String label;
  final Size size;
  final String text;
  final bool pass;

  const Textfiledsign({
    super.key,
    this.label = "Name Organistion",
    this.size = const Size(250, 50),
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
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          validator: (value) {
            return null;
          }
          //   // تحقق من المدخلات
          //   if (value == null || value.isEmpty) {
          //     return text.isNotEmpty ? text : 'This field is required';
          //   }
          //   return null;
          // },
          //   onChanged: (value) {
          //     // قم بإضافة المنطق المطلوب هنا
          //     print("Input value: $value");
          //   },
          ),
    );
  }
}
