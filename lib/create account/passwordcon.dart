import 'package:flutter/material.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart';
import 'package:get/get.dart';

class Passwordcon extends StatelessWidget {
  final RegistrationController controller = Get.find<RegistrationController>();
  final String labelText;
  final String hintText;
  final TextEditingController?
      textEditingController; // إضافة خاصية TextEditingController

  Passwordcon({
    super.key,
    this.labelText = 'Password',
    this.hintText = 'Password must be at least 6 characters long',
    this.textEditingController, // إضافة الخاصية هنا
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
          controller: textEditingController ??
              controller
                  .passwordController, // استخدام controller إذا لم يتم تمرير نص
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value? Icons.visibility: Icons.visibility_off,//اذا تحقق شرط يعمل بعد السؤال اذا لم يتحقق بعد نقطتين رأسيتين
                color: Colors.white,
              ),
              onPressed: () {
                controller.isPasswordVisible.value =
                    !controller.isPasswordVisible.value;
              },
            ),
          ),
          obscureText: !controller.isPasswordVisible.value,
          validator: (value) {
            // التحقق من أن القيمة ليست فارغة
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            // التحقق من طول كلمة المرور
            else if (value.length < 6) {
              return hintText;
            }
            // تحقق من المطابقة مع كلمة المرور الأصلية
            else if (textEditingController != null &&
                textEditingController!.text.isNotEmpty) {
              // تحقق من أن المتغير ليس null قبل الوصول إليه
              if (value != textEditingController!.text) {
                return 'Passwords do not match'; // نص التحذير عند عدم المطابقة
              }
            }
            return null; // العودة بnull تعني عدم وجود أخطاء
          },
        ));
  }
}
