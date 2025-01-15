import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc; // اسم مستعار للمكتبة Location

import 'package:url_launcher/url_launcher.dart';

class OrgProfileuser extends StatefulWidget {
  final String userId;

  const OrgProfileuser({super.key, required this.userId});

  @override
  State<OrgProfileuser> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfileuser> {
  final EventController controller = Get.put(EventController());
  late final String locationUrl;
  String provinceName = 'جاري تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    controller.fetchEventsForUser(widget.userId);
    controller.fetchOrganizationData(widget.userId);
    controller.fetchTodayData();
    fetchLocationUrl();
    //   fetchLocationData();
  }

  void fetchLocationData() async {
    try {
      loc.Location location = loc
          .Location(); // استخدم loc.Location بدلاً من Location لتجنب الالتباس

      // التحقق من تمكين الخدمة
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          print('خدمة الموقع غير مفعلة');
          return;
        }
      }

      // طلب الإذن للوصول إلى الموقع
      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          print('الإذن غير ممنوح');
          return;
        }
      }

      // الحصول على الإحداثيات
      loc.LocationData locationData = await location.getLocation();
      if (locationData.latitude == null || locationData.longitude == null) {
        print('تعذر الحصول على الموقع');
        return;
      }

      // تحويل الإحداثيات إلى عنوان باستخدام geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      // استخراج اسم المحافظة
      setState(() {
        provinceName = placemarks[0].administrativeArea ?? 'غير معروف';
        locationUrl =
            'https://www.google.com/maps?q=${locationData.latitude},${locationData.longitude}';
      });
    } catch (e) {
      print('خطأ في جلب البيانات: $e');
    }
  }

  void openLocation(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'تعذر فتح رابط الموقع';
    }
  }

  void fetchLocationUrl() async {
    // هنا يمكن أن يكون مصدر الرابط (Firebase أو أي مصدر آخر)
    locationUrl = 'https://maps.app.goo.gl/qzvDjCAiAw1bx5Pq6'; // تخصيص القيمة
    setState(() {}); // تحديث الواجهة
  }

  @override
  Widget build(BuildContext context) {
    final linkRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?(meet\.google\.com\/[a-zA-Z0-9\-]+|teams\.microsoft\.com\/.*|zoom\.us\/j\/[0-9]+).*$',
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Obx(() {
          var orgDataList = controller.orgData.value.toList();
          if (orgDataList.isEmpty) {
            return const Center(
              child: Text('No Organization at this time.'),
            );
          }
          final Myevent = orgDataList.first;

          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchEventsForUser(widget.userId);
              controller.fetchOrganizationData(widget.userId);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.05,
                            right: screenWidth * 0.05),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back,
                              color: Color(0xff575a60)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.05),
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/Image/Polygon 1.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                Myevent.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.phone),
                                  const SizedBox(width: 4),
                                  Text(
                                    Myevent.phone.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.location_pin),
                                      onPressed: () {
                                        openLocation(locationUrl);
                                      }),
                                  const SizedBox(width: 4),
                                  //    Text(provinceName),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (controller.orgData2.isEmpty) {
                      return const Center(
                          child: Text("No events available for today."));
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orgData2.length,
                      itemBuilder: (context, index) {
                        final eventorg = controller.orgData2[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xffdde5ec),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              // اضف هنا الإجراء عند الضغط
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                  height: screenHeight * 0.14,
                                  width: screenWidth * 0.9,
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      // الصورة داخل دائرة
                                      const CircleAvatar(
                                        radius: 45,
                                        backgroundImage: AssetImage(
                                            'assets/images/Image/Logo.png'),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // العنوان
                                            Text(
                                              eventorg.title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF3d4349),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            // التاريخ
                                            Text(
                                              "Date: ${DateFormat('dd MMMM').format(eventorg.start_time.toDate())}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF3d4349),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),

                                            if (linkRegex.hasMatch(eventorg
                                                    .link ??
                                                '')) // تحقق من تطابق الرابط مع Regex
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Image/Pin_light.png',
                                                    width: 24,
                                                    height: 24, // حجم الأيقونة
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    "Online",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF3d4349),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16), // فاصل بين العناصر
                    );
                  }),
                ],
              ),
            ),
          );
        }),
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
            ],
          ),
        ),
      ),
    );
  }
}
