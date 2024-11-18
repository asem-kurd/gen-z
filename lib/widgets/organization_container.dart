import 'package:flutter/material.dart';

class OrganizationContainer extends StatelessWidget {
  final String imgPath;
  final String orgName;
  final String orgInfo;
  final String orgNumber;

  const OrganizationContainer(
      {super.key,
      required this.imgPath,
      required this.orgName,
      required this.orgInfo,
      required this.orgNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0xffDEE1D2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 46, // Keep the avatar size fixed
                backgroundImage: AssetImage(imgPath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    orgName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      Text(
                        orgInfo,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  Padding(
                    padding: const EdgeInsets.only(right: 89),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_outlined),
                        Text(
                          orgNumber,
                          style:
                              const TextStyle(fontSize: 12, color: Color(0xff7C142F)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
