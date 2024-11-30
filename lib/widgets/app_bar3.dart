import 'package:flutter/material.dart';

class CustomAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final String appBarName;

  const CustomAppBar3(
      {super.key, required this.toolbarHeight, required this.appBarName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
