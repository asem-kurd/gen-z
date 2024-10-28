import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar({Key? key, required this.toolbarHeight}) : super(key: key);

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
          size: 40,
        ),
        tooltip: 'Open Menu',
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.language,
            size: 40,
          ),
          tooltip: 'Change Language',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
