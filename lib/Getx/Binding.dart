import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Authviewmodel>(() => Authviewmodel());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    Get.put(CreateUser());
  }
}
