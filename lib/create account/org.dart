import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/txtfiled.dart';
import 'package:get/get.dart';

class Org extends StatelessWidget {
  const Org({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF887CB0),
        body: OrgRegistrationForm(),
      ),
    );
  }
}

class OrgRegistrationForm extends StatelessWidget {
  OrgRegistrationForm({super.key});

  final List<String> _cities = [
    'Amman',
    'Irbid',
    'Zarqa',
    'Madaba',
    'Mafraq',
    'Aqaba',
    'Karak',
    'Tafila',
    'Ma\'an',
    'Ajloun',
    'Jerash',
    'Balqa'
  ];

  // استخدم RxList لإدارة الحالة
  final RxList<String> _selectedCities = <String>[].obs;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  //final TextEditingController _orgNameController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();

  // Form key to manage form state
  final _formKey = GlobalKey<FormState>();

  void _showCitySelectionDialog(BuildContext context) async {
    final List<String> tempSelectedCities = List.from(_selectedCities);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select Cities"),
              content: SingleChildScrollView(
                child: Column(
                  children: _cities.map((city) {
                    return CheckboxListTile(
                      title: Text(city),
                      value: tempSelectedCities.contains(city),
                      onChanged: (bool? value) {
                        // استخدم setState الخاص بالحوار لتحديث واجهة المستخدم
                        setState(() {
                          if (value == true) {
                            tempSelectedCities.add(city);
                          } else {
                            tempSelectedCities.remove(city);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    // تحديث المدن المحددة خارج الحوار
                    _selectedCities.value = tempSelectedCities;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Organization Registration",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Organization Name Field
                const Txtfiled(
                  label: "Organization Name",
                  size: Size(300, 50),
                  text: "please enter organization name",
                ),

                const SizedBox(height: 20),

                // Email Address
                const Txtfiled(
                  label: "Email Address",
                  size: Size(300, 50),
                  text: "Please enter an email address",
                ),

                const SizedBox(height: 20),

                // City Selection Button
                Obx(() => TextButton(
                      onPressed: () => _showCitySelectionDialog(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        _selectedCities.isEmpty
                            ? "Select Cities"
                            : "Selected Cities: ${_selectedCities.join(", ")}",
                        style: const TextStyle(color: Colors.purple),
                      ),
                    )),
                if (_selectedCities.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Please select at least one city',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 20),

                // Password Field
                const Txtfiled(
                  label: "Password",
                  size: Size(300, 50),
                  text: "Please enter a password",
                ),

                const SizedBox(height: 20),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Create Account Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 50,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedCities.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account created successfully!'),
                        ),
                      );
                    } else if (_selectedCities.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select at least one city'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Create Organization Account",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const Org());
