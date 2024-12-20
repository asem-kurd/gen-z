import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/appbar2.dart';
import 'package:flutter_application_99/Repetitions/events_foryou.dart';
import 'package:flutter_application_99/Repetitions/iconbar.dart';
import 'package:flutter_application_99/repetitions/all_events.dart';
import 'package:flutter_application_99/widget_event/popular.dart';
import 'package:get/get.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar2(appBarName: "20".tr, toolbarHeight: screenHeight * 0.05),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFebe9f2),
                Color(0xFFfaead6),
              ],
            ),
          ),
          child:  DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: const Color.fromARGB(255, 33, 40, 113),
                  labelColor: const Color.fromARGB(255, 33, 40, 113),
                  unselectedLabelColor: const Color(0xff5A5D62),
                  tabs: [
                    Tab(
                      text: "21".tr,
                    ),
                    Tab(
                      text: "22".tr,
                    ),
                    Tab(
                      text: "23".tr,
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
      ),
    );
  }
}
