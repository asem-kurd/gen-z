import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/filter_event_buttom.dart';
import 'package:get/get.dart';

class BtnsSet extends StatelessWidget {
  const BtnsSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
              iconColor: Color(0xffE4AB56),
              icon: Icons.help_outline,
              btnName: "13".tr,
            ),
            FilterEventsBtn(
              iconColor: Color(0xff4584C5),
              icon: Icons.school,
              btnName: "14".tr,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xff97CA4F),
                icon: Icons.code,
                btnName: "15".tr),
            SizedBox(
              width: 2,
            ),
            FilterEventsBtn(
                iconColor: Color(0xffC6986E),
                icon: Icons.sports_basketball_sharp,
                btnName: "16".tr),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterEventsBtn(
                iconColor: Color(0xffB978B3),
                icon: Icons.health_and_safety,
                btnName: "17".tr),
            SizedBox(
              width: 20,
            ),
            FilterEventsBtn(
                iconColor: Color(0xff176824),
                icon: Icons.grass,
                btnName: "18".tr),
          ],
        ),
      ),
    ]);
  }
}
