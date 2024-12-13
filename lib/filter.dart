import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/appbar.dart';
import 'package:flutter_application_99/Repetitions/appbar2.dart';
import 'package:flutter_application_99/Repetitions/iconbar.dart';
import 'package:flutter_application_99/Repetitions/listviewimage.dart';
import 'package:flutter_application_99/menu_fillter.dart';

class FilterEventsScreen extends StatelessWidget {
  const FilterEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFebe9f2),
                Color(0xFFfaead6),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          iconSize: 37,
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                        const Text(
                          'GEN-Z ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Arial Rounded MT Bold',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff65625E),
                            height: 1.2,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: 37,
                      onPressed: () {},
                      icon: const Icon(Icons.language),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xff65625E),
                thickness: 2,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      right: screenWidth * 0.5,
                    ),
                    child: const Text(
                      "Filter Events",
                      style: TextStyle(
                          color: Color(0xff65625E),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
              Column(
                children: [
                  const BtnsSet(),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, bottom: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "#News",
                        style: TextStyle(
                          color: Color(0xff676259),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150, // Define height for the ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, // Adjust for number of items
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: EventImageStack(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
