import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/taple_firebase/user_taple.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/service/event.dart';
import 'package:flutter_application_99/service/firestoreOrg.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:flutter_application_99/view_model/user_model.dart';

class EventController extends GetxController {
  RxList<Firestoreorg> myorganization2 = <Firestoreorg>[].obs;
  var events = <EventModel>[].obs;
  RxList<Firestoreorg> myorganization = <Firestoreorg>[].obs;
  var isLoading = true.obs;
  var orgData = <Firestoreorg>[].obs;
  var orgData2 = <EventModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var UserData = <UserModel>[].obs;
  var eventIds = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    fetchAllUsers();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      UserData.value = snapshot.docs.map((doc) {
        return UserModel(
          userId: doc.id, // يمكنك إضافة userId إذا كان موجود
          email: doc['email'],
          name: doc['name'],
          password: '',
          phone: 0.0,
          address: '',
          age: 0.0,
          role: 'user',
          events: {},
          gender: '',
        );
      }).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch users: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void fetchEvents() async {
    try {
      isLoading.value = true; // تأكيد أنك في وضع التحميل
      final snapshot =
          await FirebaseFirestore.instance.collection('events').get();
      events.value =
          snapshot.docs.map((doc) => EventModel.fromJson(doc.data())).toList();
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false; // إيقاف مؤشر التحميل
    }
  }

  void fetchAllUsers() async {
    try {
      isLoading.value = true; // عرض مؤشر التحميل
      final snapshot =
          await FirebaseFirestore.instance.collection('Orgnaization').get();

      // تحديث قائمة المنظمات
      myorganization.value = snapshot.docs
          .map((doc) => Firestoreorg.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching organizations: $e");
    } finally {
      isLoading.value = false; // إخفاء مؤشر التحميل
    }
  }

  // جلب بيانات المنظمة باستخدام userId
  void fetchOrganizationData(String userId) {
    try {
      isLoading.value = true; // تأكيد أنك في وضع التحميل
      FirebaseFirestore.instance
          .collection('Orgnaization') // اختر مجموعة Orgnaization
          .where('userId', isEqualTo: userId) // تصفية البيانات باستخدام userId
          .snapshots() // مراقبة التغيرات مباشرة
          .listen((snapshot) {
        var data = snapshot.docs.map((doc) {
          return Firestoreorg.fromJson(
              doc.data()); // تحويل البيانات إلى نموذج Firestoreorg
        }).toList();

        orgData.value = data; // تحديث orgData بقائمة البيانات المحملة
      });
    } catch (e) {
      print('Error fetching organization data: $e'); // في حال حدوث خطأ
    } finally {
      isLoading.value = false; // إيقاف مؤشر التحميل
    }
  }

  void fetchEventsForUser(String userId) {
    try {
      isLoading.value = true;
      FirebaseFirestore.instance
          .collection('events')
          .where('userId', isEqualTo: userId)
          .snapshots() // مراقبة التغيرات مباشرة
          .listen((snapshot) {
        orgData2.value = snapshot.docs
            .map((doc) => EventModel.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      print("Error fetching events for user: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchEventsFilter(String typeEvent) async {
    try {
      isLoading.value = true;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('type_event', isEqualTo: typeEvent) // تصفية حسب نوع الحدث
          .get();

      orgData2.value = snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEventFromAllUsers(String eventId) async {
    try {
      // احصل على جميع المستخدمين
      final userSnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      for (var userDoc in userSnapshot.docs) {
        final userId = userDoc.id;

        // البحث عن الأحداث المرتبطة بـ eventId
        final eventSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('events')
            .where('eventId', isEqualTo: eventId) // استخدم "eventId" كاسم الحقل
            .get();

        // تحقق إذا تم العثور على مستندات
        if (eventSnapshot.docs.isNotEmpty) {
          for (var eventDoc in eventSnapshot.docs) {
            print(
                'Deleting event: ${eventDoc.id} for user: $userId'); // طباعة لمعرفة ماذا يحدث
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('events')
                .doc(eventDoc.id)
                .delete(); // حذف المستند
          }
        } else {
          print('No events found for eventId: $eventId in user: $userId');
        }
      }

      print('Event deleted from all users successfully');
    } catch (e) {
      print('Error deleting event from all users: $e');
    }
  }

  void fetchAndDeleteEventsForUser(String userId) async {
    try {
      isLoading.value = true;

      var snapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('userId', isEqualTo: userId)
          .get();

      print('Found ${snapshot.docs.length} events to delete.');

      // Delete each event from both collections
      for (var doc in snapshot.docs) {
        try {
          String eventId = doc.id;

          // Delete event from 'events' collection
          await FirebaseFirestore.instance
              .collection('events')
              .doc(eventId)
              .delete();
          print('Event with ID $eventId has been deleted.');

          // Delete event from 'Users/{userId}/events' collection
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('events')
              .doc(eventId)
              .delete();
          print('Event with ID $eventId deleted from User\'s events.');
        } catch (e) {
          print('Error deleting event ${doc.id}: $e');
        }
      }
    } catch (e) {
      print("Error fetching and deleting events for user: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEventFromAllUsers2(String eventId) async {
    try {
      // جلب جميع المستخدمين
      var usersSnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      // التنقل عبر كل مستخدم
      for (var userDoc in usersSnapshot.docs) {
        String userId = userDoc.id; // معرف المستخدم

        // الوصول إلى مجموعة "events" داخل المستخدم
        var userEventsSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('events')
            .where(FieldPath.documentId,
                isEqualTo: eventId) // البحث عن المستند باستخدام eventId
            .get();

        // إذا وجد المستند، قم بحذفه
        for (var eventDoc in userEventsSnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('events')
              .doc(eventDoc.id)
              .delete();

          print("Deleted event $eventId for user $userId");
        }
      }

      print("Event $eventId has been deleted for all users.");
    } catch (e) {
      print("Error deleting event $eventId for all users: $e");
    }
  }
}
