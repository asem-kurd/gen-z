import 'package:flutter/material.dart';

class TextFileDsign extends StatelessWidget {
  final String label;
  final Size size;
  final String text;
  final bool pass;

  const TextFileDsign({
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF9386a1), // لون الخلفية
          borderRadius: BorderRadius.circular(29), // الحواف
        ),
        child: TextFormField(
          obscureText: pass, // لإخفاء النص إذا كان كلمة مرور
          autofillHints: const [AutofillHints.email], // خاصية الملء التلقائي
          decoration: InputDecoration(
            hintText: label, // النص التوضيحي
            hintStyle: const TextStyle(color: Colors.grey), // لون النص التوضيحي
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            border: InputBorder.none, // إزالة الحدود الافتراضية
          ),
          validator: (value) {
            // تحقق من المدخلات
            if (value == null || value.isEmpty) {
              return text.isNotEmpty ? text : 'This field is required';
            }
            return null;
          },
          onChanged: (value) {
            // قم بإضافة المنطق المطلوب هنا
            print("Input value: $value");
          },
        ),
      ),
    );
  }
}
