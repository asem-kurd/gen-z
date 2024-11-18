import 'package:flutter/material.dart';
import 'package:flutter_application_99/repetitions/organizations.dart';
import 'package:flutter_application_99/widgets/appbar.dart';
import 'package:flutter_application_99/repetitions/icon_bar.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching the screen dimensions for responsive design
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          //appBar: CustomAppBar1(toolbarHeight: screenHeight * 0.09),
          // ignore: prefer_const_constructors
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color.fromARGB(255, 254, 228, 192), Color(0xffF3F1FB)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar1(),
                Padding(
                  padding: EdgeInsets.only(left: 35, top: 30, bottom: 25),
                  child: Text(
                    "Organizations",
                    style: TextStyle(fontSize: 40, color: Color(0xff5A5D62)),
                  ),
                ),
                // Wrap ListView with Expanded to make it take available space
                Organizations(),
                ],
            ),
          ),
          bottomNavigationBar: const CustomBottomAppBar(),
        ),
      ),
    );
  }
}
