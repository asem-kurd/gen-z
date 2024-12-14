import 'package:flutter/material.dart';
import 'package:flutter_application_99/theme_service.dart';
import 'package:popover/popover.dart';

class CustomAppBar1 extends StatelessWidget {
  const CustomAppBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PopupMenuButton(
          offset: Offset(0, 50), // Adjusts the popup position
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: false, // Make the title non-interactive
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22),
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
                hoverColor: Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 16), // Space between icon and text
                    Text("Profile"),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.black),
                    SizedBox(width: 16), // Space between icon and text
                    Text("Home"),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  ThemeService().changeTheme();
                }, // Handle tap actions
                hoverColor: Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(Icons.dark_mode, color: Colors.black),
                    SizedBox(width: 16), // Space between icon and text
                    Text("Dark Theme"),
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
                        Icon(Icons.filter_alt, color: Colors.black),
                        SizedBox(width: 16), // Space between icon and text
                        Text("Filter events"),
                      ],
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
                hoverColor: Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    SizedBox(width: 16), // Space between icon and text
                    Text("Settings"),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: InkWell(
                onTap: () {}, // Handle tap actions
                hoverColor: Color(0xffBDBEC0), // Hover color
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 16), // Space between icon and text
                    Text("Log out"),
                  ],
                ),
              ),
            ),
          ],
        ),
        IconButton(
          iconSize: 33,
          onPressed: () {},
          icon: const Icon(Icons.language),
        ),
      ],
    );
  }
}
