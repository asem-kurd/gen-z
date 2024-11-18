import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/appbar.dart';
import 'package:flutter_application_99/widgets/appbar2.dart';
import 'package:flutter_application_99/repetitions/icon_bar.dart';
import 'package:flutter_application_99/repetitions/list_view_image.dart';
import 'package:flutter_application_99/repetitions/button_set.dart';

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
          child: ListView(
            children: [
              CustomAppBar2(
                appBarName: "GEN-Z",
                toolbarHeight: screenHeight * 0.09,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      right: screenWidth * 0.5,
                      bottom: screenHeight * 0.05,
                    ),
                    child: const Text(
                      "Filter Events",
                      style: TextStyle(
                          color: Color(0xff65625E),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
        bottomNavigationBar: const CustomBottomAppBar(),
      ),
    );
  }
}
