import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar2({super.key, required this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "GEN-Z",
          style: TextStyle(
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
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(top: 90),
          child: Divider(
            height: 50,
            thickness: 2,
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
