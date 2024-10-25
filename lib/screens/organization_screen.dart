import 'package:flutter/material.dart';

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: screenHeight * 0.09, // Responsive toolbar height
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 40,
              ),
              tooltip: 'Open Menu',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.language,
                  size: 40,
                ),
                tooltip: 'Change Language',
              ),
            ],
          ),
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
                                  radius: 60, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
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
                                  radius: 60, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
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
                                  radius: 60, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
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
                                  radius: 60, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
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
                                  radius: 60, // Keep the avatar size fixed
                                  backgroundImage:
                                      AssetImage("assets/imgs/logo.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Organization Name",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
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
          bottomNavigationBar: BottomAppBar(
            color: const Color(0xffEBE9F2), // Background color for the footer
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home button or other icons can go here
                  IconButton(
                    icon: const Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: Color(0xff5A5D62),
                    ),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.event, color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.build_outlined,
                        color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_2_outlined,
                        color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
