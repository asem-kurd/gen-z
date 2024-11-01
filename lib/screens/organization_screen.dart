import 'package:flutter/material.dart';
import 'package:gen_z/models/app_bar1.dart';
// import 'package:gen_z/models/app_bar2.dart';
import 'package:gen_z/models/bottom_app_bar.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching the screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar1(toolbarHeight: screenHeight * 0.09),
          // ignore: prefer_const_constructors
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color.fromARGB(255, 254, 228, 192), Color(0xffF3F1FB)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 90),
                  child: Text(
                    "Organizations",
                    style: TextStyle(fontSize: 40, color: Color(0xff5A5D62)),
                  ),
                ),
                // Wrap ListView with Expanded to make it take available space
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xffDEE1D2),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 46, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline),
                                        Text(
                                          "   Page . Non-profit organization",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 7)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 89),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone_outlined),
                                          Text(
                                            "   (06) 580 6161",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7C142F)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xffDEE1D2),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 46, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline),
                                        Text(
                                          "   Page . Non-profit organization",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 7)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 89),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone_outlined),
                                          Text(
                                            "   (06) 580 6161",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7C142F)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xffDEE1D2),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 46, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline),
                                        Text(
                                          "   Page . Non-profit organization",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 7)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 89),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone_outlined),
                                          Text(
                                            "   (06) 580 6161",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7C142F)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xffDEE1D2),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 46, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline),
                                        Text(
                                          "   Page . Non-profit organization",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 7)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 89),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone_outlined),
                                          Text(
                                            "   (06) 580 6161",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7C142F)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xffDEE1D2),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 46, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline),
                                        Text(
                                          "   Page . Non-profit organization",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 7)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 89),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone_outlined),
                                          Text(
                                            "   (06) 580 6161",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7C142F)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomAppBar(),
        ),
      ),
    );
  }
}
