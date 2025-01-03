import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/appbar2.dart';
import 'package:flutter_application_99/Repetitions/events_foryou.dart';
import 'package:flutter_application_99/Repetitions/iconbar.dart';
import 'package:flutter_application_99/repetitions/all_events.dart';
import 'package:flutter_application_99/widget_event/popular.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: const DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: Column(
                children: [
                  TabBar(
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
                  Expanded(
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
        ),
      ),
    );
  }
}
