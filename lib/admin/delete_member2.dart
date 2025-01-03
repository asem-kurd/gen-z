import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/view_model/user_model.dart';
import 'package:get/get.dart';

import '../Getx/EventController.dart';

class MemberScreen2 extends StatelessWidget {
  final EventController controller = Get.put(EventController());
  MemberScreen2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    controller.fetchUserData(); // Get the organization data
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xffbfbfbf),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Delete Members',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff737270),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              var userDataList = controller.UserData;
              if (userDataList.isEmpty) {
                return const Center(
                  child: Text('No users available at this time.'),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // التمرير عمودي
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(
                        color: const Color(0xffe3e3e3),
                        width: 2,
                      ),
                    ),
                    child: Table(
                      border: const TableBorder(
                        top: BorderSide(color: Color(0xffe3e3e3), width: 2),
                        bottom: BorderSide(color: Color(0xffe3e3e3), width: 2),
                        horizontalInside:
                            BorderSide(color: Color(0xffe3e3e3), width: 2),
                        verticalInside: BorderSide.none,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        _buildTableHeader(),
                        for (var user in userDataList)
                          _buildTableRow(user.name, user.email, user),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Name',
              style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.11,
                  letterSpacing: 0.06,
                  textBaseline: TextBaseline.alphabetic,
                  color: Color(0xff91908e)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Email',
              style: TextStyle(
                fontFamily: 'Arial Rounded MT Bold',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.11,
                letterSpacing: 0.06,
                textBaseline: TextBaseline.alphabetic,
                color: Color(0xff91908e),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Action',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff91908e)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String name, String email, UserModel user) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff91908e),
                fontFamily: 'Arial Rounded MT Bold',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.11,
                letterSpacing: 0.06,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              email,
              style: const TextStyle(
                color: Color(0xff91908e),
                fontFamily: 'Arial Rounded MT Bold',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.11,
                letterSpacing: 0.06,
                textBaseline: TextBaseline.alphabetic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          icon: const ImageIcon(
            AssetImage('assets/images/Image/Icon (5).png'),
            color: Color.fromARGB(255, 16, 15, 15),
          ),
          onPressed: () async {
            try {
              // معرف المستخدم
              String userId = user.userId;

              // مرجع المستخدم في مجموعة Users
              var userDocRef =
                  FirebaseFirestore.instance.collection('Users').doc(userId);

              // حذف Subcollection "events" المرتبطة
              var eventsSnapshot = await userDocRef.collection('events').get();
              if (eventsSnapshot.docs.isNotEmpty) {
                for (var eventDoc in eventsSnapshot.docs) {
                  await eventDoc.reference.delete();
                }
              }

              // حذف المستخدم من مجموعة Users
              await userDocRef.delete();

              // مرجع المستخدم في مجموعة أخرى (مثل OtherCollection)
              var otherDocRef = FirebaseFirestore.instance.collection('events');

              // البحث عن المستند المرتبط بـ userId في OtherCollection
              var otherSnapshot = await otherDocRef
                  .where('relatedUserId', isEqualTo: userId)
                  .get();
              for (var doc in otherSnapshot.docs) {
                await doc.reference.delete(); // حذف المستند المرتبط
              }

              // تحديث البيانات المحلية
              controller.UserData.removeWhere((u) => u.userId == userId);

              // رسالة نجاح
              Get.snackbar(
                'Success',
                'User and their events have been deleted successfully from all collections',
                snackPosition: SnackPosition.BOTTOM,
              );
            } catch (e) {
              // عرض رسالة خطأ
              Get.snackbar(
                'Error',
                'Failed to delete user or their related data: $e',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
        ),
      ],
    );
  }
}
