import 'package:flutter/material.dart';
import 'package:flutter_application_99/repetitions/all_events.dart';
import 'package:flutter_application_99/repetitions/events_for_you.dart';
import 'package:flutter_application_99/repetitions/icon_bar.dart';
import 'package:flutter_application_99/repetitions/organizations.dart';
import 'package:flutter_application_99/repetitions/popular_events.dart';
import 'package:flutter_application_99/widgets/appbar2.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

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
          child: DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Column(
              children: [
                CustomAppBar2(
                  appBarName: "Events",
                  toolbarHeight: screenHeight * 0.09,
                ),
                const TabBar(
                  indicatorColor: Color.fromARGB(255, 33, 40, 113),
                  labelColor: Color.fromARGB(255, 33, 40, 113),
                  unselectedLabelColor: Color(0xff5A5D62),
                  tabs: [
                    Tab(
                      text: "For you",
                    ),
                    Tab(
                      text: "All Events",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      EventsForYou(),
                      AllEvents(),
                      PopularEvents(),
                    ],
                  ),
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
