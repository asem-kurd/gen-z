import 'package:flutter/material.dart';

class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar1({super.key, required this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.language,
            size: 30,
          ),
          tooltip: 'Change Language',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
