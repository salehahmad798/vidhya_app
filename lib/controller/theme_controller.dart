// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhya_app/utils/app_colors.dart';

class ThemeController extends GetxController {
  RxBool isLightTheme = false.obs;

  saveThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', isLightTheme.value);
  }

  getAndApplyTheme() async {
    isLightTheme.value = await _getThemeFromPref();
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  _getThemeFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var theme = prefs.getBool('theme');
    return theme ?? false;
  }

  ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primaryappcolor,
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        disabledColor: Colors.grey,
      ));

  ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primarybackColor,
      brightness: Brightness.light,
      primaryColor: Colors.green,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        disabledColor: Colors.grey,
      ));
}
