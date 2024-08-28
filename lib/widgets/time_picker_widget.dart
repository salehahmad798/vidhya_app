
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/utils/app_colors.dart';

import '../controller/theme_controller.dart';

timePiker(context) async {
  ThemeController themeController = Get.put(ThemeController());
  final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        // Customize the look and feel of the dialog using a custom theme.

        if (themeController.isLightTheme.value) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primarywhiteColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
                secondary: AppColors.primarybackColor,
                onSecondary: Colors.white,
                surfaceContainerHighest: AppColors.primarybackColor.withOpacity(0.3),
              ),
            ),
            child: child!,
          );
        } else {
          return Theme(
            data: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primarywhiteColor,
                onPrimary: Colors.white,
                surface: AppColors.primarybackColor,
                onSurface: Colors.white,
                surfaceTint: AppColors.primarybackColor,
                secondary: AppColors.backgroundColor,
                onSecondary: Colors.white,
                surfaceContainerHighest: Colors.transparent,
              ),
            ),
            child: child!,
          );
        }
      });
  if (newTime != null) {
    // dialogController.updateTime(newTime);
    return newTime;
  }
}