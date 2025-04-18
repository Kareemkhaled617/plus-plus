import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var currentIndex1 = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void updateIndex1(int index) {
    currentIndex1.value = index;
  }
}
