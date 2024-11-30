import 'package:flutter/material.dart';
import 'package:flutter_application_99/repetitions/icon_bar.dart';
import 'package:flutter_application_99/widgets/app_bar3.dart';

class AddEvents extends StatelessWidget {
  const AddEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFebe9f2),
                Color(0xFFfaead6),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomAppBar3(
                  appBarName: "Events",
                  toolbarHeight: screenHeight * 0.09,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
      ),
    );
  }
}
