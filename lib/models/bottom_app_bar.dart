import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xffEBE9F2), // لون خلفية الـ BottomAppBar
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, size: 30, color: Color(0xff5A5D62)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.event, color: Color(0xff5A5D62)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.build_outlined, color: Color(0xff5A5D62)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_2_outlined, color: Color(0xff5A5D62)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
