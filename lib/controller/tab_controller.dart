import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  var selectedTabIndex = 0.obs;
  RxBool profile = false.obs;
  RxBool platformConverter = false.obs;
  var date = ''.obs;

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

}