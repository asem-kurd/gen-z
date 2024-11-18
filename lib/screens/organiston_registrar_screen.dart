import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/repetitions/gradent_circle.dart';
import 'package:flutter_application_99/widgets/TextFileDsign.dart';
import 'package:flutter_application_99/widgets/txtfiled.dart';
import 'package:flutter_application_99/package/drowdown.dart';
import 'package:get/get.dart';

class OrganistonRegistrarScreen extends StatelessWidget {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController interestController = TextEditingController();

  OrganistonRegistrarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPainter(),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: height * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "GEN-Z",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RussoOne",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    "Your Journey Begins Here,",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Welcome to GEN-Z,",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  const TextFileDsign(label: "Organization Name"),
                  SizedBox(height: height * 0.03),
                  const TextFileDsign(label: "Organization Address"),
                  SizedBox(height: height * 0.03),
                  const TextFileDsign(
                    label: "Email Address",
                  ),
                  SizedBox(height: height * 0.03),
                  AppTextField(
                    datalist: [
                      SelectedListItem(name: "Male"),
                      SelectedListItem(name: "Female"),
                    ],
                    textEditingController: countryController,
                    title: "Select Gender",
                    hint: "Gender",
                    isCitySelected: true,
                  ),
                  SizedBox(height: height * 0.03),
                  AppTextField(
                    datalist: [
                      SelectedListItem(name: "Health"),
                      SelectedListItem(name: "Help"),
                      SelectedListItem(name: "Technology"),
                      SelectedListItem(name: "Education"),
                      SelectedListItem(name: "Environment"),
                      SelectedListItem(name: "Sports"),
                    ],
                    textEditingController: interestController,
                    title: "Select Interest",
                    hint: "Interest",
                    isCitySelected: true,
                  ),
                  SizedBox(height: height * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.8, height * 0.05),
                      backgroundColor: Colors.grey.shade800,
                    ),
                    onPressed: () {
                      
                      Get.to(() => OrganistonRegistrarScreen());
                    },
                    child: const Text(
                      "Create your GEN-Z Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
