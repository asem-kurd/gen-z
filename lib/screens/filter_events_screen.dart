import 'package:flutter/material.dart';
import 'package:gen_z/models/app_bar2.dart';
import 'package:gen_z/models/bottom_app_bar.dart';
import 'package:gen_z/models/btns_set.dart';
import 'package:gen_z/widgets/event_image_stack.dart';

class FilterEventsScreen extends StatelessWidget {
  const FilterEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar2(toolbarHeight: 600 * 0.09),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 130, left: 30, bottom: 30),
              // to make the text on the left:
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Filter Events",
                  style: TextStyle(
                      color: Color(0xff65625E),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
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
                    height: 170, // Define height for the ListView
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
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
      ),
    );
  }
}