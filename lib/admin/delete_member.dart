import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:get/get.dart';

import '../Getx/EventController.dart';

class MemberScreen extends StatelessWidget {
  final EventController controller = Get.put(EventController());
  final eventdata = <EventModel>[].obs;

   MemberScreen({super.key}); // مراقبة قائمة الأحداث

  @override
  Widget build(BuildContext context) {
    final String userId = Get.arguments as String;
    final screenWidth = MediaQuery.of(context).size.width;

    controller.fetchOrganizationData(userId);

    void fetchEventsByOrgId(String userId) async {
      try {
        print('Fetching data for userId: $userId');
        final snapshot = await FirebaseFirestore.instance
            .collection('events')
            .where('userId', isEqualTo: userId)
            .get();

        if (snapshot.docs.isNotEmpty) {
          print(
              'Raw data from Firestore: ${snapshot.docs.map((doc) => doc.data())}');
          var fetchedData = snapshot.docs
              .map((doc) => EventModel.fromJson(doc.data()))
              .toList();
          print('Fetched Data: $fetchedData');
          eventdata.value = fetchedData;
        } else {
          print('No data found for userId: $userId');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    fetchEventsByOrgId(userId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              var orgDataList = controller.orgData.value.toList();
              if (orgDataList.isEmpty) {
                return const Center(
                  child: Text('No Organization at this time.'),
                );
              }
              final Myevent = orgDataList.first;

              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/Image/Polygon 1.png',
                        ),
                        radius: 50,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Myevent.name,
                              style: const TextStyle(
                                color: Color(0xff484e53),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.error_outline, size: 20),
                                SizedBox(width: 2),
                                Text(
                                  "Page · Non-profit organization",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff484e53),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  Myevent.phone.toString(),
                                  style: const TextStyle(color: Color(0xff7c142f)),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Handle delete action
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff3d4349)),
                                        borderRadius: BorderRadius.circular(18),
                                        color: const Color(0xff3d4349),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text(
              'Event List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (eventdata.isEmpty) {
                return const Center(
                  child: Text('No events found for this user.'),
                );
              }

              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    // عرض الأعمدة حسب المحتوى
                    border: const TableBorder(
                      top: BorderSide(color: Color(0xffe3e3e3), width: 2),
                      bottom: BorderSide(color: Color(0xffe3e3e3), width: 2),
                      horizontalInside:
                          BorderSide(color: Color(0xffe3e3e3), width: 1),
                    ),
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Event ID',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Actions',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      // Rows for each event
                      ...eventdata.map((event) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 4.0), // تقليل الهامش من الجهة اليمنى
                              child: Text(event.eventid.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 4.0), // تقليل الهامش من الجهة اليمنى
                              child: Text(event.title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 4.0), // تقليل الهامش من الجهة اليمنى
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () async {
                                          try {
                                            var orgDataList = controller
                                                .orgData.value
                                                .toList();
                                            final Myevent = orgDataList.first;

                                            var eventSnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('events')
                                                    .where('eventid',
                                                        isEqualTo:
                                                            event.eventid)
                                                    .get();

                                            if (eventSnapshot.docs.isNotEmpty) {
                                              var eventDoc =
                                                  eventSnapshot.docs.first;
                                              await FirebaseFirestore.instance
                                                  .collection('events')
                                                  .doc(eventDoc.id)
                                                  .delete();
                                              var orgEventSnapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'Orgnaization')
                                                      .doc(Myevent.userid)
                                                      .get(); // الحصول على مستند المنظمة

                                              if (orgEventSnapshot.exists) {
                                                var orgEventDoc = orgEventSnapshot
                                                        .data()?['My_Events'] ??
                                                    {}; // الوصول إلى الـ Map داخل المستند

                                                if (orgEventDoc
                                                    .containsKey(eventDoc.id)) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'Orgnaization')
                                                      .doc(Myevent.userid)
                                                      .update({
                                                    'My_Events.${eventDoc.id}':
                                                        FieldValue
                                                            .delete() // حذف الحدث من الـ Map
                                                  });
                                                }
                                              }
                                              Get.snackbar("Success",
                                                  "Event deleted successfully");
                                            }
                                          } catch (e) {
                                            print(
                                                'Error deleting the first event: $e');
                                          }
                                        }),
                                  ]),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
