import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AppColors {
  static final textColor = Theme.of(Get.context!).colorScheme.surface;
  static const buttonBg = Color.fromARGB(255, 114, 110, 117);
  static const shadowColor = Color(0xffB4B3B5);

  // Filter button colors
  static const helpColor = Color(0xffE4AB56);
  static const educationColor = Color(0xff4584C5);
  static const technologyColor = Color(0xff97CA4F);
  static const sportsColor = Color(0xffC6986E);
  static const healthColor = Color(0xffB978B3);
  static const entertainmentColor = Color(0xff176824);
}

class FilterButtonData {
  final String type;
  final Color iconColor;
  final IconData icon;
  final String label;

  const FilterButtonData({
    required this.type,
    required this.iconColor,
    required this.icon,
    required this.label,
  });
}

class FilterEventsScreen extends StatelessWidget {
  FilterEventsScreen({super.key});

  final EventController _controller = Get.put(EventController());

  final List<FilterButtonData> filterButtons = [
    const FilterButtonData(
      type: 'Help',
      iconColor: AppColors.helpColor,
      icon: Icons.help_outline,
      label: 'Help',
    ),
    const FilterButtonData(
      type: 'Education',
      iconColor: AppColors.educationColor,
      icon: Icons.school,
      label: 'Edu',
    ),
    const FilterButtonData(
      type: 'Technology',
      iconColor: AppColors.technologyColor,
      icon: Icons.code,
      label: 'Tech',
    ),
    const FilterButtonData(
      type: 'Sports',
      iconColor: AppColors.sportsColor,
      icon: Icons.sports_basketball_sharp,
      label: 'Sports',
    ),
    const FilterButtonData(
      type: 'Health',
      iconColor: AppColors.healthColor,
      icon: Icons.health_and_safety,
      label: 'Health',
    ),
    const FilterButtonData(
      type: 'Nature',
      iconColor: AppColors.entertainmentColor,
      icon: Icons.grass,
      label: 'Nature',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Arial Rounded MT Bold',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
          titleMedium: TextStyle(
            color: AppColors.textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Arial Rounded MT Bold',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
          titleMedium: TextStyle(
            color: Colors.white70,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Divider(color: AppColors.textColor, thickness: 2),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Filter Events",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              _buildFilterButtonsGrid(),
              _buildEventsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                iconSize: 37,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                'GEN-Z',
                style: Theme.of(Get.context!).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtonsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2.5,
      children: filterButtons
          .map((button) => _buildFilterButton(
                type: button.type,
                iconColor: button.iconColor,
                icon: button.icon,
                btnName: button.label,
              ))
          .toList(),
    );
  }

  Widget _buildEventsList() {
    return SizedBox(
      height: 150,
      child: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _controller.orgData2.length,
          itemBuilder: (context, index) => _buildEventCard(index),
        );
      }),
    );
  }

  Widget _buildEventCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Stack(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/event.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.all(5),
              color: Colors.black54,
              child: Text(
                _controller.orgData2[index].title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required String type,
    required Color iconColor,
    required IconData icon,
    required String btnName,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Colors.black87,
              width: 1.0,
            ),
          ),
        ),
        onPressed: () => _controller.fetchEventsFilter(type),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              btnName,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
