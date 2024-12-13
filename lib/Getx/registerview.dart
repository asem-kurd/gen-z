import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AuthviewModel.dart';

class Registerview extends GetView<Authviewmodel> {
  const Registerview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Registerview"),
      ),
    );
  }
}