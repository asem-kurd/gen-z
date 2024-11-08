import 'package:flutter/material.dart';
import 'package:gen_z/widgets/filter_events_btns.dart';

class BtnsSet extends StatelessWidget {
  const BtnsSet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(
        children: [
          FilterEventsBtn(
            iconColor: Color(0xffE4AB56),
            icon: Icons.help_outline,
            btnName: "Help",
          ),
          SizedBox(
            width: 20,
          ),
          FilterEventsBtn(
            iconColor: Color(0xff4584C5),
            icon: Icons.school,
            btnName: "Education",
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          FilterEventsBtn(
              iconColor: Color(0xff97CA4F),
              icon: Icons.code,
              btnName: "Technology"),
          SizedBox(
            width: 20,
          ),
          FilterEventsBtn(
              iconColor: Color(0xffC6986E),
              icon: Icons.sports_basketball_sharp,
              btnName: "Sports"),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          FilterEventsBtn(
              iconColor: Color(0xffB978B3),
              icon: Icons.health_and_safety,
              btnName: "Health"),
          SizedBox(
            width: 20,
          ),
          FilterEventsBtn(
              iconColor: Color(0xff176824),
              icon: Icons.grass,
              btnName: "Environment"),
        ],
      ),
    ]);
  }
}
