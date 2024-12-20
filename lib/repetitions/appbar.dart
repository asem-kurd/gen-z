import 'package:flutter/material.dart';
import 'package:flutter_application_99/locale/locale_controller.dart';
import 'package:flutter_application_99/theme_controller.dart';
import 'package:popover/popover.dart';
import 'package:get/get.dart';

class CustomAppBar1 extends StatelessWidget {
  const CustomAppBar1({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLanguage = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PopupMenuButton(
          offset: const Offset(0, 50), // Adjusts the popup position
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              enabled: false, // Make the title non-interactive
              child: Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GEN-Z",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: const Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(width: 16), // Space between icon and text
                    Text("24".tr),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: const Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    const Icon(Icons.home, color: Colors.black),
                    const SizedBox(width: 16), // Space between icon and text
                    Text("25".tr),
                  ],
                ),
              ),
            ),
            /**theme*************************************** */
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  final themeController = Get.find<ThemeController>();
                  themeController
                      .toggleTheme(); // Use the ThemeController to handle the change
                },
                hoverColor: const Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode, color: Colors.black),
                    const SizedBox(width: 16), // Space between icon and text
                    Text("26".tr),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22, top: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.filter_alt, color: Colors.black),
                        const SizedBox(
                            width: 16), // Space between icon and text
                        Text("27".tr),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: const Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    const Icon(Icons.settings, color: Colors.black),
                    const SizedBox(width: 16), // Space between icon and text
                    Text("28".tr),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: const Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.black),
                    const SizedBox(width: 16), // Space between icon and text
                    Text("29".tr),
                  ],
                ),
              ),
            ),
          ],
        ),
        PopupMenuButton(
          offset: const Offset(0, 50), // Adjusts the popup position
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                controllerLanguage.changeLanguage("ar");
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("العربية"),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                controllerLanguage.changeLanguage("en");
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("English"),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
          child: Icon(Icons.language),
        )
      ],
    );
  }
}
