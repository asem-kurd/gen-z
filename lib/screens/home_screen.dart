import 'package:flutter/material.dart';
import 'package:gen_z/screens/profile_screen.dart';

class HomeSecreen extends StatelessWidget {
  const HomeSecreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfileScreen();
                    },
                  ),
                );
              },
              child: null,
            ),
          ),
        ));
  }
}
