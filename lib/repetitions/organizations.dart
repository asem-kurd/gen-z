import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/organization_container.dart';

class Organizations extends StatelessWidget {
  const Organizations({super.key});

  final List<OrganizationContainer> orgs = const [
    OrganizationContainer(
      imgPath: "assets/images/1.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
    OrganizationContainer(
      imgPath: "assets/images/2.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
    OrganizationContainer(
      imgPath: "assets/images/3.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
    OrganizationContainer(
      imgPath: "assets/images/4.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
    OrganizationContainer(
      imgPath: "assets/images/5.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
    OrganizationContainer(
      imgPath: "assets/images/6.png",
      orgName: "مؤسسة ولي العهد",
      orgInfo: "مؤسسه غير ربحية",
      orgNumber: "0797493629",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          orgs[0],
          orgs[1],
          orgs[2],
          orgs[3],
          orgs[4],
          orgs[5],
        ],
      ),
    );
  }
}
