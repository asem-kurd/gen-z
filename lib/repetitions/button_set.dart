import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/filter_event_btn.dart';

class BtnsSet extends StatelessWidget {
  const BtnsSet({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.sizeOf(context).height;
    // final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
              iconColor: Color(0xffE4AB56),
              icon: Icons.help_outline,
              btnName: "Help       ",
            ),
            FilterEventsBtn(
              iconColor: Color(0xff4584C5),
              icon: Icons.school,
              btnName: "EDU  ",
            ),
          ],
        ),
      ),
      // SizedBox(
      //   width: screenWidth * 0.05,
      // ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xff97CA4F),
                icon: Icons.code,
                btnName: "TECH "),
            // SizedBox(
            //   width: 2,
            // ),
            FilterEventsBtn(
                iconColor: Color(0xffC6986E),
                icon: Icons.sports_basketball_sharp,
                btnName: "Sports     "),
          ],
        ),
      ),
      // SizedBox(
      //   width: screenWidth * 0.05,
      // ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xffB978B3),
                icon: Icons.health_and_safety,
                btnName: "Health     "),
            // SizedBox(
            //   width: screenWidth * 0.05,
            // ),
            FilterEventsBtn(
                iconColor: Color(0xff176824),
                icon: Icons.grass,
                btnName: " ENVR"),
          ],
        ),
      ),
    ]);
  }
}
