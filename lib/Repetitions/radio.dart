import 'package:flutter/material.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart'; // تأكد من أن هذا هو المسار الصحيح لوحدة التحكم
import 'package:get/get.dart';

class GenderRadio extends StatelessWidget {
  final RegistrationController controller = Get.find<RegistrationController>();

  final String title;
  final String value;
  GenderRadio({
    super.key,
    this.title = "Male",
    this.value = "Male",
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          leading: Radio<String>(
            value: value,
            groupValue: controller.selectedGender.value,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGender.value = value;
              }
            },
          ),
        ),
      ),
    );
  }
}
