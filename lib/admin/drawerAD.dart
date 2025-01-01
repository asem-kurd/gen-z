import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
              ),
              const SizedBox(width: 190),
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
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 30),
              ListTile(
                leading: Image.asset('assets/images/Image/Icon (4).png'),
                title: const Text('Home',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset('assets/images/Image/globe-01.png'),
                title: const Text('DarkMode',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                onTap: () {
                  // استخدم ThemeService لتغيير الوضع الداكن
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                },
              ),
              const Divider(thickness: 1, color: Colors.grey),
              ListTile(
                leading: Image.asset('assets/images/Image/Icon (1).png'),
                title: const Text('Settings',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/Image/Icon (2).png'),
                title: const Text('Logout',
                    style: TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/CreateUser',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
