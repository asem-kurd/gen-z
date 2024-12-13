import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final String appBarName;

  const CustomAppBar2(
      {super.key, required this.toolbarHeight, required this.appBarName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // final screenWidth = MediaQuery.sizeOf(context).width;
    return AppBar(
      titleSpacing: 1,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          size: 30,
        ),
        tooltip: 'Open Menu',
        color: const Color(0xff65625E),
      ),
      title: Text(
        appBarName,
        style: const TextStyle(
          color: Color(0xff65625E),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.equalizer_rounded,
            size: 30,
            color: Color(0xff65625E),
          ),
          tooltip: 'Filteration',
        ),
      ],
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.1),
        child: const Divider(
          height: 50,
          thickness: 2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}