import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final String appBarName;

  const CustomAppBar2(
      {super.key, required this.toolbarHeight, required this.appBarName});

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    Theme.of(context).colorScheme.primary;

    final screenHeight = MediaQuery.sizeOf(context).height;
    // final screenWidth = MediaQuery.sizeOf(context).width;
    return AppBar(
      titleSpacing: 1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      title: Text(
        appBarName,
        style: const TextStyle(),
      ),
      actions: [
        //text clicabel Save
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {},
            child: const Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.15),
        child: const Divider(
          height: 50,
          thickness: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
