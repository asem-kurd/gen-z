import 'package:flutter/material.dart';
import 'package:gen_z/screens/filter_events_screen.dart';
// import 'package:gen_z/screens/organization_screen.dart';
// import 'package:gen_z/screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const FilterEventsScreen();
  }
}
