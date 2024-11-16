import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 33,
          onPressed: () {},
          icon: const Icon(Icons.menu),
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
