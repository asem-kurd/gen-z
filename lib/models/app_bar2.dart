import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar2({super.key, required this.toolbarHeight});

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
        title: const Text("GEN-Z"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.equalizer_rounded,
              size: 30,
              color: Colors.black,
            ),
            tooltip: 'Filteration',
          ),
        ],
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Divider(
            height: 50,
            thickness: 2,
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
