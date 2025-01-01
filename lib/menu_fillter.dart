import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/filter_event_buttom.dart';

class BtnsSet extends StatelessWidget {
  const BtnsSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
              iconColor: Color(0xffE4AB56),
              icon: Icons.help_outline,
              btnName: " Help           ",
            ),
            FilterEventsBtn(
              iconColor: Color(0xff4584C5),
              icon: Icons.school,
              btnName: " Education      ",
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xff97CA4F),
                icon: Icons.code,
                btnName: "Technology"),
            SizedBox(
              width: 2,
            ),
            FilterEventsBtn(
                iconColor: Color(0xffC6986E),
                icon: Icons.sports_basketball_sharp,
                btnName: "Sports            "),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xffB978B3),
                icon: Icons.health_and_safety,
                btnName: "Health        "),
            FilterEventsBtn(
                iconColor: Color(0xff176824),
                icon: Icons.grass,
                btnName: "Environment "),
          ],
        ),
      ),
    ]);
  }
}
