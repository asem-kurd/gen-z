import 'package:flutter/material.dart';
import 'package:get/get.dart';

double screenWidth = 0;
double screenHeight = 0;

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState
                ?.openDrawer(); // فتح الـ Drawer عند الضغط على الأيقونة
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GEN-Z',
                  style: TextStyle(
                      color: Color(0xFF42454b),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                ),
                const SizedBox(
                  width: 190,
                ),
                GestureDetector(
                  onTap: () {
                    print('Share button pressed');
                  },
                  child: const Image(
                    image: AssetImage('assets/images/Image/share.png'),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Icon (3).png'),
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Icon (4).png'),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Date_fill@3x.png'),
                  title: const Text(
                    'Events',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/server-02 (1).png'),
                  title: const Text(
                    'Organization',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/globe-01.png'),
                  title: const Text(
                    'Language',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Filter.png'),
                  title: const Text(
                    'Filter events',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Icon (1).png'),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // إغلاق الـ Drawer
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/images/Image/Icon (2).png'),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
