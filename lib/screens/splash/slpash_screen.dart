import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/screens/home_screen/home_screen.dart';
import 'package:vidhya_app/screens/mode_tracking/mood_tracking_summary_screen.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIntro();
  }

  void checkIntro() {
    Timer(const Duration(seconds: 4), () {
      // if(GetStorage().read('token')==null){
      Get.offAll(() => HomeScreen());
      // }else{
      //   Get.offAll(() => const BotomnavbarScreen());
      //
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhiteColor,
      body: Center(
        child: Image(
          image: const AssetImage(AppImaes.applogo),
          height: 185.h,
          width: 139.w,
        ),
      ),
    );
  }
}
