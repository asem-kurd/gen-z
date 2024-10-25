import 'package:flutter/material.dart';
import 'package:gen_z/screens/organization_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const OrganizationScreen();
  }
}
