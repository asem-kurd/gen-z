import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final RxString selectedValue = 'Help'.obs;

  late String event_type, upload_image;

  late String title = titleController.text;

  late String description = descriptionController.text;

  late String eventlocation = eventloc.text;

  late Timestamp end_time, start_time;

  late int required_number;

  late GeoPoint Latitude;

  late List<String> image_url;

  late String link;

  final ValueNotifier<int?> requiredNumber = ValueNotifier<int?>(null);
  // State management for required number
  late String linkmeet = LinkController.text;

  // Controllers for text fields
  late TextEditingController titleController = TextEditingController();

  late TextEditingController descriptionController = TextEditingController();

  late TextEditingController eventloc = TextEditingController();

  // Placeholder for selected dates
  final ValueNotifier<DateTime?> startDate = ValueNotifier<DateTime?>(null);

  final ValueNotifier<DateTime?> endDate = ValueNotifier<DateTime?>(null);

  ValueNotifier<String?> selectedLocation = ValueNotifier(null);

  final TextEditingController LinkController = TextEditingController();

  bool isEventLocFilled = false;

  bool isEventLinkFilled = false;

  // دالة لحفظ البيانات في Firestore
  Future<DateTime?> _pickDate(
      BuildContext context, ValueNotifier<DateTime?> notifier) async {
    return await showDatePicker(
      context: context, // تأكد من تمرير BuildContext هنا
      initialDate: notifier.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _pickTime(
      BuildContext context, ValueNotifier<DateTime?> notifier) async {
    return await showTimePicker(
      context: context,
      initialTime: notifier.value != null
          ? TimeOfDay.fromDateTime(notifier.value!)
          : TimeOfDay.now(),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Select Date & Time';
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Function to handle saving the event
  void _saveEvent(BuildContext context) {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide a title for the event")),
      );
      return;
    }
    print("Event saved: ${titleController.text}");
    // Add further logic for saving the event
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button on the left
            TextButton(
              onPressed: () {
                requiredNumber.value = null;
                startDate.value = null;
                endDate.value = null;
                titleController.clear();
                descriptionController.clear();
                // Show a snackbar indicating the form has been cleared
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All fields have been cleared.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }, // Close the screen
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial Rounded MT Bold',
                    color: Color.fromARGB(213, 27, 31, 38),
                    fontSize: 18),
              ),
            ),
            // Title in the center
            const Expanded(
              child: Center(
                child: Text(
                  'New Event',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial Rounded MT Bold',
                      color: Color.fromARGB(213, 27, 31, 38),
                      fontSize: 18),
                ),
              ),
            ),
            // Save button on the right
            TextButton(
              onPressed: () async {
                try {
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    // جلب بيانات المنظمة بناءً على معرف المستخدم
                    DocumentSnapshot orgDoc = await FirebaseFirestore.instance
                        .collection('Orgnaization')
                        .doc(currentUser.uid)
                        .get();

                    final eventid = FirebaseFirestore.instance
                        .collection('events')
                        .doc()
                        .id;

                    if (orgDoc.exists) {
                      // التحقق من صحة المتغيرات قبل إنشاء الحدث
                      if (eventlocation.isEmpty &&
                          LinkController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Either an event location or a meeting link must be provided.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      // التحقق من صحة eventlocation (رابط Google Maps)
                      if (eventlocation.isNotEmpty) {
                        final locationRegex = RegExp(
                            r'^(https?:\/\/)?(www\.)?(google\.[a-z]+\/maps\/(place|dir)\/|maps\.app\.goo\.gl\/).*');

                        if (!locationRegex.hasMatch(eventlocation)) {
                          Get.snackbar(
                            'Error',
                            'Invalid Google Maps link for the event location.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                      }

                      // التحقق من صحة link (رابط Google Meet أو Teams أو Zoom)
                      if (LinkController.text.isNotEmpty) {
                        final linkRegex = RegExp(
                            r'^(https?:\/\/)?(www\.)?(meet\.google\.com\/[a-zA-Z0-9\-]+|teams\.microsoft\.com\/.*|zoom\.us\/j\/[0-9]+).*$');
                        if (!linkRegex.hasMatch(LinkController.text)) {
                          Get.snackbar(
                            'Error',
                            'Invalid meeting link. Only Google Meet, Teams, or Zoom links are allowed.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                      }
                      EventModel defaultEvent = EventModel(
                        type_event: selectedValue.value,
                        eventid: eventid,
                        userId: currentUser.uid,
                        title: titleController.text,
                        description: description,
                        start_time: Timestamp.fromDate(startDate.value!),
                        end_time: Timestamp.fromDate(endDate.value!),
                        required_number: requiredNumber.value ?? 0,
                        image_url: [], // إضافة الصور إذا لزم الأمر
                        Latitude: const GeoPoint(0.0, 0.0),
                        phone:
                            orgDoc['phone'], // جلب رقم الهاتف من بيانات المنظمة
                        upload_image: '', // رابط الصورة المرفقة مع الحدث
                        eventLocation: eventlocation,
                        link: LinkController.text,
                      );

                      DocumentReference eventDoc = await FirebaseFirestore
                          .instance
                          .collection('events')
                          .add(defaultEvent.toJson());

                      // تحديث معرّف الحدث في وثيقة المنظمة
                      await FirebaseFirestore.instance
                          .collection('Orgnaization')
                          .doc(currentUser.uid)
                          .update({
                        'My_Events.${eventDoc.id}': defaultEvent.toJson(),
                      });

                      Get.snackbar(
                        'Success',
                        'Default event created and linked to the organization.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Organization data not found.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      'No user is currently logged in.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Failed to create event: $e',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial Rounded MT Bold',
                    color: Color.fromARGB(213, 27, 31, 38),
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Event title input
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(141, 27, 31, 38), // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Event Title',
                  hintStyle: const TextStyle(
                    color: Colors.grey, // Placeholder text color
                    fontSize: 16, // Placeholder text size
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear, // "X" icon
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      titleController.clear();
                    },
                  ),
                  border: InputBorder.none, // Remove default border
                ),
                onSaved: (value) {
                  title = value!;
                },
              ),
            ),

            const SizedBox(height: 20),

            // Date pickers
            Center(
              child: Container(
                child: Row(
                  children: [
                    CustomPaint(
                      size: const Size(264, 56),
                      painter: RPSCustomPainter2(),
                      child: Expanded(
                        child: ValueListenableBuilder<DateTime?>(
                          valueListenable: startDate,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () async {
                                final selectedDate =
                                    await _pickDate(context, startDate);
                                if (selectedDate != null) {
                                  final selectedTime =
                                      await _pickTime(context, startDate);
                                  if (selectedTime != null) {
                                    startDate.value = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.calendar_today, size: 20),
                                    Text(
                                      _formatDateTime(value),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Start date and time picker
                    const SizedBox(width: 15),
                    // SizedBox(width: 10),
                    // End date and time picker
                    CustomPaint(
                      size: const Size(194, 60),
                      painter: RPSCustomPainter(),
                      child: Expanded(
                        child: ValueListenableBuilder<DateTime?>(
                          valueListenable: endDate,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () async {
                                final selectedDate =
                                    await _pickDate(context, endDate);
                                if (selectedDate != null) {
                                  final selectedTime =
                                      await _pickTime(context, endDate);
                                  if (selectedTime != null) {
                                    endDate.value = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 12, top: 12, bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.calendar_today, size: 20),
                                    Text(_formatDateTime(value),
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                'Required Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(213, 27, 31, 38),
                ),
              ),
              trailing: ValueListenableBuilder<int?>(
                valueListenable: requiredNumber,
                builder: (context, value, child) {
                  return Text(
                    value?.toString() ?? 'Not Specified',
                    style: const TextStyle(
                      color: Color(0xFF1B1F26),
                    ),
                  );
                },
              ),
              onTap: () async {
                final result = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Enter Required Number'),
                      content: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter a number',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          requiredNumber.value = int.tryParse(value);
                        },
                        onSaved: (value) {
                          requiredNumber.value = int.tryParse(value!);
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(123);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );

                if (result != null) {
                  print("User entered number: $result");
                }
              },
            ),

            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: eventloc,
                decoration: InputDecoration(
                  hintText: 'Location',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: isEventLinkFilled
                        ? Colors.grey
                        : const Color(0xFF474448), // تغيير اللون
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(
                    Icons.location_off,
                    color: isEventLinkFilled
                        ? Colors.grey
                        : const Color(0xFF474448), // تغيير لون الأيقونة
                  ),
                  filled: true,
                  fillColor: isEventLinkFilled
                      ? Colors.grey.shade300
                      : Colors.white10, // تغيير لون الخلفية
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location link';
                  }
                  final regex = RegExp(
                      r'^(https?:\/\/)?(www\.)?google\.[a-z]+\/maps\/(place|dir)\/.*$');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid Google Maps link';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    isEventLocFilled = value.isNotEmpty;
                  });
                  eventlocation = value;
                },
                onSaved: (value) {
                  eventlocation = value.toString();
                },
                enabled:
                    !isEventLinkFilled, // تعطيل إذا كان الحقل الآخر ممتلئًا
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: LinkController,
                decoration: InputDecoration(
                  hintText: 'Enter meeting link',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: isEventLocFilled
                        ? Colors.grey
                        : const Color(0xFF474448), // تغيير اللون
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(
                    Icons.link,
                    color: isEventLocFilled
                        ? Colors.grey
                        : const Color(0xFF474448), // تغيير لون الأيقونة
                  ),
                  filled: true,
                  fillColor: isEventLocFilled
                      ? Colors.grey.shade300
                      : Colors.white10, // تغيير لون الخلفية
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a meeting link';
                  }
                  // التحقق من صحة الروابط المقبولة
                  final regex = RegExp(
                      r'^(https?:\/\/)?(www\.)?(google\.[a-z]+\/maps\/(place|dir)\/.*|meet\.google\.com\/[a-zA-Z0-9\-]+|teams\.microsoft\.com\/.*|zoom\.us\/j\/[0-9]+).*$');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid link (Google Maps, Google Meet, Teams, or Zoom)';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    isEventLinkFilled = value.isNotEmpty;
                  });
                  link = value;
                },
                onSaved: (value) {
                  link = value.toString();
                },
                enabled: !isEventLocFilled, // تعطيل إذا كان الحقل الآخر ممتلئًا
              ),
            ),

            // Location input
            // ListTile(
            //   title: const Text(
            //     'Location',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Color.fromARGB(213, 27, 31, 38),
            //     ),
            //   ),
            //   trailing: Row(
            //     mainAxisSize:
            //         MainAxisSize.min, // Ensures the row takes up minimal space
            //     children: [
            //       Image.asset(
            //         'assets/images/Image/Pin_light.png',
            //         width: 24, // Adjust the size of the image if necessary
            //         height: 24,
            //       ),

            //       const SizedBox(
            //           width: 8), // Add spacing between text and the image
            //       ValueListenableBuilder<String?>(
            //         valueListenable:
            //             selectedLocation, // Use a ValueNotifier for dynamic updates
            //         builder: (context, value, child) {
            //           return Text(value ??
            //               'Not Specified'); // Display selected location
            //         },
            //       ),
            //     ],
            //   ),
            //   onTap: () async {
            //     // Open a dialog to select a location
            //     String? result = await showDialog<String>(
            //       context: context,
            //       builder: (context) {
            //         return LocationSelectionDialog(); // Dialog implementation below
            //       },
            //     );

            //     if (result != null) {
            //       selectedLocation.value =
            //           result; // Update the selected location
            //     }
            //   },
            // ),

            // // Required number input
            // ListTile(
            //   title: const Text('Required Number',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: Color.fromARGB(213, 27, 31, 38),
            //       )),
            //   trailing: ValueListenableBuilder<int?>(
            //     valueListenable: requiredNumber,
            //     builder: (context, value, child) {
            //       return Text(
            //         value?.toString() ?? 'Not Specified',
            //         style: const TextStyle(
            //           color: Color(0xFF1B1F26),
            //         ),
            //       );
            //     },
            //   ),
            //   onTap: () async {
            //     int? result = await showDialog<int>(
            //       context: context,
            //       builder: (context) {
            //         return NumberInputDialog(); // Opens the dialog
            //       },
            //     );
            //     if (result != null) {
            //       requiredNumber.value = result; // Update state
            //     }
            //   },
            // ),
            const SizedBox(height: 20),

            // Description input

            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 27, 31, 38),
                            fontFamily: 'Arial Rounded MT Bold',
                            fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial Rounded MT Bold',
                              color: Color.fromARGB(213, 27, 31, 38),
                              fontSize: 18),
                        ),
                      )
                    ]),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFAEAAB0), // Background color
                    borderRadius:
                        BorderRadius.circular(45), // Apply border radius
                  ),
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Type Here...',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(129, 27, 31, 38),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      border: InputBorder.none,
                    ),
                    onSaved: (value) {
                      description = value!;
                    },
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),

            // Upload images section
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Upload Images',
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(height: 10),
            //     Container(
            //       height: 150,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(Icons.cloud_upload, size: 50, color: Colors.grey),
            //             SizedBox(height: 10),
            //             Text(
            //               'Drag and drop files here\nOR',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(color: Colors.grey),
            //             ),
            //             SizedBox(height: 10),
            //             OutlinedButton(
            //               onPressed: () {
            //                 // Logic to upload a file
            //               },
            //               child: Text('Upload File'),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class NumberInputDialog extends StatefulWidget {
  const NumberInputDialog({super.key});

  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Required Number'),
      content: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          hintText: 'Enter a number',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          // required_number= int.tryParse(value!);
        },
        onChanged: (value) {
          selectedNumber = int.tryParse(value);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog without returning data
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(selectedNumber); // Return selected number
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

Future<List<dynamic>> fetchLocations() async {
  const String apiKey = 'AIzaSyBN2kfQ75yZP6BwPJhDU1nXZPQAv-D-2f4';
  const String location =
      '31.963158,35.930359'; // Latitude, Longitude (Example: Amman, Jordan)
  const int radius = 5000; // Search radius in meters
  const String type = 'organization';
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&type=$type&key=$apiKey');
  final response =
      await http.get(url); // Type of location to search for (adjust as needed)

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'OK' && data.containsKey('results')) {
      return data['results'] as List<dynamic>;
    } else {
      throw Exception('API error: ${data['status']}');
    }
  } else {
    throw Exception('Failed to load locations (HTTP ${response.statusCode})');
  }
}

class LocationSelectionDialog extends StatelessWidget {
  const LocationSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Location'),
      content: FutureBuilder<List<dynamic>>(
        future: fetchLocations(), // Fetch locations from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final locations = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  title: Text(location['name']),
                  onTap: () {
                    Navigator.of(context)
                        .pop(location['name']); // Return selected location
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No locations found.'));
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(4.5, 1);
    path_0.lineTo(2.60259, 1);
    path_0.lineTo(3.67507, 2.56523);
    path_0.lineTo(21.8013, 29.0197);
    path_0.lineTo(3.65694, 57.4622);
    path_0.lineTo(2.67592, 59);
    path_0.lineTo(4.5, 59);
    path_0.lineTo(175.5, 59);
    path_0.lineTo(176.5, 59);
    path_0.lineTo(176.5, 58);
    path_0.lineTo(176.5, 2);
    path_0.lineTo(176.5, 1);
    path_0.lineTo(175.5, 1);
    path_0.lineTo(4.5, 1);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01123596;
    paint0Stroke.color = const Color(0xffD9D9D9).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(2, 1);
    path_0.lineTo(1, 1);
    path_0.lineTo(1, 2);
    path_0.lineTo(1, 58);
    path_0.lineTo(1, 59);
    path_0.lineTo(2, 59);
    path_0.lineTo(173, 59);
    path_0.lineTo(173.543, 59);
    path_0.lineTo(173.839, 58.5445);
    path_0.lineTo(192.339, 30.0445);
    path_0.lineTo(192.699, 29.4902);
    path_0.lineTo(192.33, 28.9418);
    path_0.lineTo(173.83, 1.44182);
    path_0.lineTo(173.533, 1);
    path_0.lineTo(173, 1);
    path_0.lineTo(2, 1);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01030928;
    paint0Stroke.color = const Color(0xffD9D9D9).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffAEAAB0).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void testApi() async {
  try {
    final locations = await fetchLocations();
    print(locations); // Should print a list of locations
  } catch (e) {
    print("Error: $e");
  }
}
