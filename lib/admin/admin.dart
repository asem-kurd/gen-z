import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/admin/drawerAD.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/admin/delete_member.dart';

class Admin extends StatelessWidget {
  final EventController myorg = Get.put(EventController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Admin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AdminDrawer(), // استدعاء Drawer المخصص هنا
      body: Column(
        children: [
          _buildHeader(),
          const Divider(color: Color(0xffd9d9d9), thickness: 2),
          SizedBox(height: screenHeight * 0.025),
          _buildSearchBar(screenWidth),
          SizedBox(height: screenHeight * 0.045),
          _buildActionButton("Add News", () {}, 150),
          SizedBox(height: screenHeight * 0.2),
          _buildActionButton("Delete Organizations", () {}, 200),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (myorg.myorganization.isEmpty) {
                  return const Center(child: Text("No organizations found"));
                }
                return ListView.builder(
                  itemCount: myorg.myorganization.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final org = myorg.myorganization[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: screenHeight * 0.16,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/Image/Polygon 1.png'),
                              radius: 50,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    org.name,
                                    style: const TextStyle(
                                      color: Color(0xff484e53),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(Icons.error_outline, size: 20),
                                      SizedBox(width: 2),
                                      Text(
                                        "Page · Non-profit organization",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff484e53)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone, size: 16),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          org.phone.toDouble().toString(),
                                          style: const TextStyle(
                                              color: Color(0xff7c142f)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          var eventId = org.userid;
                                          print(eventId);
                                          Get.to(const MemberScreen(),
                                              arguments: eventId);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.1),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff3d4349)),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: const Color(0xff3d4349),
                                            ),
                                            child: const Text(
                                              "Delete  Event",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu, size: 30),
          ),
          const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: screenWidth * 0.9,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Color(0xffafaeab)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xff696969)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed, double width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: width, // نفس العرض لكلا الزرين
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 184, 183, 183),
              borderRadius: BorderRadius.circular(21),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff737270),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
